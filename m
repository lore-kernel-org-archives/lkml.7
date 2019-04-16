Return-Path: <SRS0=BZT9=SS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AEEC10F13
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F76B20868
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Apr 2019 03:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I0zPpGeL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfDPDu1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 23:50:27 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:44806 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbfDPDu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 23:50:27 -0400
Received: by mail-vs1-f65.google.com with SMTP id j184so10730659vsd.11
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 20:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6O1vt8zyWL7/vWWLrY3NNehV0EhKXQOq2R1IZBHsBM0=;
        b=I0zPpGeLyvzz+csxGqpsE7zsCViKtWZhQaelft8C+qhDNxi30FqHEvOz2fVzv5d1+M
         ssIe7zjb3ELGM0QBfLlIM3E4lc4GF4kTNNAJybOtOZLnBWfr2Hkzy457MNmC5ybMQk2E
         Ko1+7yx9uOJu+W4AQSdHiN2Grir4tOwuZCWDA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6O1vt8zyWL7/vWWLrY3NNehV0EhKXQOq2R1IZBHsBM0=;
        b=s9F8EMROLNtCzB2U8qvWsNHnfaHftAa3T0ghSGJ0ltJbF1TVsJiZZRT8huETNlLxQy
         lTpqu0cj7rfMWY2UV9nQIJLt8fmn5I5Jpxeuyd/Z+bAtey9lATVmexbZszovTVr95lP1
         RivNDAiJ1mhXXleC/xC2bYqfUNdumvIJl+gd10jcqJ3REzrq7FWRgoplUNC9YTXccJv2
         ypuNcLX6I/hCTmAusFAFR9pknOB65bkflweUM3gkdmxPIZhoSdTtsO9QUeNHVD79BXBM
         SX9rJvGK1s5VKYLhClJuZMwxqadqnqCrkx95r634d7dg4u7LXMKc5KPPUSRvPVCg/oOr
         pfVA==
X-Gm-Message-State: APjAAAXHTdGCBgxaISvJSCVzGLP09gIkhtGCjXeDO2uQDN8L+xlF+RDr
        E0k1e3NKTSBM3qmWA9TLNaYnXfYublw=
X-Google-Smtp-Source: APXvYqxtzeblmvHfSZN/geacSlXLfK3VzXT/hOc9WmHChNnAqGr1HlxbTUlGd3QWsk/2ggUOf5KZhw==
X-Received: by 2002:a67:7444:: with SMTP id p65mr41199701vsc.104.1555386626053;
        Mon, 15 Apr 2019 20:50:26 -0700 (PDT)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id g19sm8677800vkf.33.2019.04.15.20.50.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Apr 2019 20:50:23 -0700 (PDT)
Received: by mail-ua1-f44.google.com with SMTP id l22so6259051uao.8
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 20:50:23 -0700 (PDT)
X-Received: by 2002:ab0:154e:: with SMTP id p14mr3882445uae.48.1555386622555;
 Mon, 15 Apr 2019 20:50:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190320163116.39275-1-joel@joelfernandes.org>
 <CAOesGMheoZda84OSz9spQ7p66wot5S_9aaqaKC=QYp+8utASXA@mail.gmail.com>
 <20190408203601.GF133872@google.com> <CAOesGMibHCuMPCYkc8V++Z2Kuf3YQf_OjYn18GvDgzTy6ubV=g@mail.gmail.com>
 <CAJWu+or0hWce9+7aEfTHoOR8cptRbzHYVL-bPdJWGZH20dbo7Q@mail.gmail.com>
 <CAOesGMiuGK-Sbqo2z=1ab070JONav1LF82MRRLCdX-4+14_XZA@mail.gmail.com>
 <20190411031540.ehezr6kq7ouobpzx@ast-mbp.dhcp.thefacebook.com>
 <CAOesGMgiPB=7FE7tXXHes7WSLfByyPxirOStoH21NZqMwaUihQ@mail.gmail.com> <20190415104109.64d914f3@gandalf.local.home>
In-Reply-To: <20190415104109.64d914f3@gandalf.local.home>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 15 Apr 2019 22:50:10 -0500
X-Gmail-Original-Message-ID: <CAGXu5j+KPVRcOJ3Ue9ZQF93GyaDhvCnFCvJ_C3WKCx2=SNdDyg@mail.gmail.com>
Message-ID: <CAGXu5j+KPVRcOJ3Ue9ZQF93GyaDhvCnFCvJ_C3WKCx2=SNdDyg@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] Provide in-kernel headers to make extending kernel easier
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Olof Johansson <olof@lixom.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Manoj Rao <linux@manojrajarao.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        atish patra <atishp04@gmail.com>,
        Daniel Colascione <dancol@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Karim Yaghmour <karim.yaghmour@opersys.com>,
        Kees Cook <keescook@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shuah Khan <shuah@kernel.org>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 15, 2019 at 9:41 AM Steven Rostedt <rostedt@goodmis.org> wrote:
> I agree with this assessment. We shouldn't use config.gz as precedence
> for this solution. config.gz should have been in debugfs to begin with,
> but I don't believe debugfs was around when config.gz was introduced.
> (Don't have time to look into the history of the two).

I don't agree with this: /proc/config.gz is used by a lot of tools
that do sanity-check of running systems. This isn't _debugging_...
it's verifying correct kernel builds. It's a fancy version of checking
/proc/version.

-- 
Kees Cook
