Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C59C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D824B20700
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 22:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oLno5OuS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbfDBWbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 18:31:46 -0400
Received: from merlin.infradead.org ([205.233.59.134]:33294 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbfDBWbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 18:31:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kVgB+eyXpP2QCuqbtkSWZ728gT9jQavI2co6hRE2UIY=; b=oLno5OuSuOxCklnp3Wf9Vq2CSR
        QvYI7Z5OCGNW2CEIPiGdv6jcp4CBWXqCVeyIMwdayTvdQ6WKRyye38MEEkqe2QwaMhc0Nc+2nn+wt
        uz+ep6FFNXbhwBPWL+CMQHssCOz5l+KJl2Nt4Dt8TOEGRwLdXnkxILhgOAk1pCzb+HCg+IWoQjlah
        PPhhPecI004tpns0Ovwak4iFjBdl+hUcNU6h5STLMs5Ogg0FJGX7yqF5AoHh9wHtavVulHfiTOWeL
        XHhxnkC4meewbSrN8+HDDUdTYcogJZRrRzy10hVTUKb7K/gicDv/SAmcG/IIAWZ+en5JSorJ86hWc
        cjOAoGeg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hBRwV-0005cs-G2; Tue, 02 Apr 2019 22:31:43 +0000
Subject: Re: [PATCH v3.1] selftests: Clean up module testing shell script
To:     Kees Cook <keescook@chromium.org>,
        "Tobin C. Harding" <tobin@kernel.org>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190402222610.GA15100@beast>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <ce347ca9-7b94-f77c-bbcd-9e73861e7182@infradead.org>
Date:   Tue, 2 Apr 2019 15:31:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190402222610.GA15100@beast>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Minor corrections below:

On 4/2/19 3:26 PM, Kees Cook wrote:
> This adjusts kselftest_module.sh to take an option "args" argument for
> modprobe arguments, removes bash-isms (since some system's /bin/sh may
> not be bash), and refactors the lib/ scripts into a shorter calling
> convention.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> This is my suggested clean-up for the module testing script for the
> strscpy_pad() series...
> ---
>  tools/testing/selftests/kselftest_module.sh  | 24 ++++++++++++--------
>  tools/testing/selftests/lib/bitmap.sh        | 17 +-------------
>  tools/testing/selftests/lib/prime_numbers.sh | 17 ++------------
>  tools/testing/selftests/lib/printf.sh        | 16 +------------
>  tools/testing/selftests/lib/strscpy.sh       | 17 ++------------
>  5 files changed, 20 insertions(+), 71 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_module.sh b/tools/testing/selftests/kselftest_module.sh
> index b5d446738614..20a897d21fde 100755
> --- a/tools/testing/selftests/kselftest_module.sh
> +++ b/tools/testing/selftests/kselftest_module.sh
> @@ -2,19 +2,20 @@
>  # SPDX-License-Identifier: GPL-2.0+
>  
>  #
> -# Runs an individual test module.  kselftest expects a separate
> -# executable for each test.  So test should each have an individial
> +# Runs an individual test module. kselftest expects a separate
> +# executable for each test. So test should each have an individial

                                  tests (?)                individual

>  # script that can call this script.
>  #
>  
>  # Individual test scrits should define these:

                     scripts

>  module=""			# filename (without the .ko).
>  desc=""				# Output prefix.
> +args=""				# modprobe arguments
>  
>  modprobe="/sbin/modprobe"
>  
>  main() {
> -    parse_args $@
> +    parse_args "$@"
>      assert_root
>      assert_have_module
>      run_module
> @@ -23,17 +24,20 @@ main() {
>  parse_args() {
>      script=${0##*/}
>  
> -    if [[ ! $# -eq 2 ]]; then
> -	echo "Usage: $script <module_name> <description> [FAIL]"
> +    if [ $# -lt 2 ]; then
> +	echo "Usage: $script <description> <module_name> [FAIL]"
>  	exit 1
>      fi
>  
> -    module=$1
> -    desc=$2
> +    desc="$1"
> +    shift || true
> +    module="$1"
> +    shift || true
> +    args="$@"
>  }
>  
>  assert_root() {
> -    if [[ $EUID -ne 0 ]]; then
> +    if [ ! -w /dev ]; then
>  	skip "please run as root"
>      fi
>  }
> @@ -45,7 +49,7 @@ assert_have_module() {
>  }
>  
>  run_module() {
> -    if $modprobe -q $module; then
> +    if $modprobe -q $module $args; then
>  	$modprobe -q -r $module
>  	say "ok"
>      else
> @@ -72,4 +76,4 @@ skip() {
>  #
>  # Main script
>  #
> -main $@
> +main "$@"


ciao.
-- 
~Randy
