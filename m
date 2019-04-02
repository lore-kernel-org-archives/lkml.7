Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92A2C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A779C20830
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 21:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NO0CC482"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfDBV1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 17:27:38 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:46007 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDBV1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 17:27:38 -0400
Received: by mail-vs1-f66.google.com with SMTP id n14so8651094vsp.12
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qiIybSas6l3Go+QGXlovOiyqOyWhoq4kX0QAlAr0REw=;
        b=NO0CC48215QJX+LvelRD6HW7H3fHFnoJuYQuFV5NlHIHgBVXT9OUGd0Pk9EBuK3AhX
         U3wniD5FUh4a326ZPT0EiC+1czgqvNkwhBWmswFLo081atSBOhBKJJMiIf5XKZ+r3uHf
         15b7iODK9dlFQsLopQUgPOornurFJG9r2UBEk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qiIybSas6l3Go+QGXlovOiyqOyWhoq4kX0QAlAr0REw=;
        b=psumDR0sGPLfV1r3W1zk0poOdWoHOZrN4jYqNXWEZX3KIhUndxeXn2lqVAS0kSrrwq
         vW2xnMbLPXPp4m6QpoBY6wZwdv58IXiZVrrsFYV6s2RB66b1SFLh+fZnWpZ+bNLXfOu6
         YT2xXVH8Gc/b7LT146WyIx3mI8REa//t21v+7yWMDntbJtm5c70Mtf90QkyL53j3LiF3
         8Rs41i7JXQl+pqpiuUIBwV+aSz+OFC+AcsX6TWFBICIr+Y/KNPaWcWdqTvVcJf6fVXPS
         Ifj/PdQPo3W8dX5Fd+5jlCtXuL9tOSmV49sSI//Vd0rLwtkXOOvsC1eNBZy25Yi1XnyA
         x9DQ==
X-Gm-Message-State: APjAAAWn7d1gvO6AMxE0MWRYKejPnKkju1QDG1GIb1GzdudaMVbdU4XE
        9yPGPSMYzypEn5q35JjfgEL/eRhVsew=
X-Google-Smtp-Source: APXvYqw7ibe0oOmfjBIeBJVIL0E9oSsOgcfS4/otedUqErhyFFs4p7xFoMt6BvSdNWaj23dgomecwA==
X-Received: by 2002:a67:828f:: with SMTP id e137mr43363765vsd.131.1554240456537;
        Tue, 02 Apr 2019 14:27:36 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id t201sm5129232vke.15.2019.04.02.14.27.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 14:27:33 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id h71so3335909vkf.5
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2019 14:27:33 -0700 (PDT)
X-Received: by 2002:a1f:29c5:: with SMTP id p188mr42395945vkp.24.1554240452727;
 Tue, 02 Apr 2019 14:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190306214226.14598-1-tobin@kernel.org> <20190306214226.14598-3-tobin@kernel.org>
In-Reply-To: <20190306214226.14598-3-tobin@kernel.org>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 2 Apr 2019 14:27:21 -0700
X-Gmail-Original-Message-ID: <CAGXu5j+=O3C6z7H5j93Z4mQkpS3f0ea_7T+LRQEnRCZCoKX8zw@mail.gmail.com>
Message-ID: <CAGXu5j+=O3C6z7H5j93Z4mQkpS3f0ea_7T+LRQEnRCZCoKX8zw@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] kselftest: Add test runner creation script
To:     "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 6, 2019 at 1:43 PM Tobin C. Harding <tobin@kernel.org> wrote:
>
> Currently if we wish to use kselftest to run tests within a kernel
> module we write a small script to load/unload and do error reporting.
> There are a bunch of these under tools/testing/selftests/lib/ that are
> all identical except for the test name.  We can reduce code duplication
> and improve maintainability if we have one version of this.  However
> kselftest requires an executable for each test.  We can move all the
> script logic to a central script then have each individual test script
> set the module name and call the main script.  There is a little bit of
> boilerplate left in each script to handle building/running tests with
> the O=/path/to/out make option.
>
> Add test runner creation script.
>
> Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> ---
>  tools/testing/selftests/kselftest_module.sh | 75 +++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100755 tools/testing/selftests/kselftest_module.sh
>
> diff --git a/tools/testing/selftests/kselftest_module.sh b/tools/testing/selftests/kselftest_module.sh
> new file mode 100755
> index 000000000000..b5d446738614
> --- /dev/null
> +++ b/tools/testing/selftests/kselftest_module.sh
> @@ -0,0 +1,75 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0+
> +
> +#
> +# Runs an individual test module.  kselftest expects a separate
> +# executable for each test.  So test should each have an individial
> +# script that can call this script.
> +#
> +
> +# Individual test scrits should define these:
> +module=""                      # filename (without the .ko).
> +desc=""                                # Output prefix.
> +
> +modprobe="/sbin/modprobe"
> +
> +main() {
> +    parse_args $@
> +    assert_root
> +    assert_have_module
> +    run_module
> +}
> +
> +parse_args() {
> +    script=${0##*/}
> +
> +    if [[ ! $# -eq 2 ]]; then
> +       echo "Usage: $script <module_name> <description> [FAIL]"
> +       exit 1
> +    fi
> +
> +    module=$1
> +    desc=$2
> +}
> +
> +assert_root() {
> +    if [[ $EUID -ne 0 ]]; then
> +       skip "please run as root"
> +    fi
> +}
> +
> +assert_have_module() {
> +    if ! $modprobe -q -n $module; then
> +       skip "module $module is not found"
> +    fi
> +}
> +
> +run_module() {
> +    if $modprobe -q $module; then
> +       $modprobe -q -r $module

Probably will need a way to pass arguments into the modprobe here, but
otherwise looks fine.

> +       say "ok"
> +    else
> +       fail ""
> +    fi
> +}
> +
> +say() {
> +    echo "$desc: $1"
> +}
> +
> +
> +fail() {
> +    say "$1 [FAIL]" >&2
> +    exit 1
> +}
> +
> +skip() {
> +    say "$1 [SKIP]" >&2
> +    # Kselftest framework requirement - SKIP code is 4.
> +    exit 4
> +}
> +
> +#
> +# Main script
> +#
> +main $@
> --
> 2.20.1
>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
