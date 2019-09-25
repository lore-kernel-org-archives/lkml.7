Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F8BC432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62842146E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 02:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GjJSySu4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633734AbfIYCBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 22:01:48 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41447 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394649AbfIYCBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 22:01:47 -0400
Received: by mail-pl1-f194.google.com with SMTP id t10so1725863plr.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2019 19:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=uIqYy2SMX20Tcq9uvPmCO0wJ3yg+s/LTa19G6srEZqo=;
        b=GjJSySu4oROh1hA/Stoy3qX4mI1buj71eo0TgGZ0Xc6HVSf65kavpf4g9jK0NxeYoK
         7/CEPsKkLPPOFoyJSe/G891p9qs52unYwRoKOcY1btLp/gY4xNst1WTkD9flrXqk7QJO
         +u/LR+JYYH7oI9+ADoYjkSBTmWnTSUyJ8Bd5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=uIqYy2SMX20Tcq9uvPmCO0wJ3yg+s/LTa19G6srEZqo=;
        b=rsDxv+6E3PDCRyfhyRCFw3iV9bzpfmw64xpR1ZF4tdFUbJ4/coJsP16E/bAtj/nGld
         rA/X/t2h0r01VxcuWg7cGfvxCmsHGCWFgOYy5bQfd6UWH7pqA6srWJhAe5MRnzp17mah
         qizb71QXImfIQgGb58VJai85q61qcO+uBsFjIvhhMVRIpM9TV9cx5LE+9SgsVJmhu1LP
         aZex5jstNEsM72lX/fsqqEQVcVJxwoszYo569yOxXYT54fUNfrNI2KvPj5Op8Vp2ZMrC
         pv6v787JT4PO6a5QY2AVcDFjv2iqeH1ly57WhOFS19qfYA8TZfLlEGA/cShyOTpvpaxV
         xCog==
X-Gm-Message-State: APjAAAWi7eKR8MkqSq8vf3v+X9WcrClfhyktVV8n7MZrnQ42Uk325SIC
        1l2jvTF1Ad9UeJ9dOAgGsJCftQ==
X-Google-Smtp-Source: APXvYqx6o0pxfgLEcvT14nZmXTP6kLAhBucqME7CfGINyYudCV3FlJLPpo51fh9Wd9f4Tr7gxp8Kwg==
X-Received: by 2002:a17:902:be12:: with SMTP id r18mr6152032pls.95.1569376905660;
        Tue, 24 Sep 2019 19:01:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r2sm3645089pfq.60.2019.09.24.19.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 19:01:44 -0700 (PDT)
Date:   Tue, 24 Sep 2019 19:01:43 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: efi-pstore: Crash logs not written
Message-ID: <201909241857.9BBBA707D@keescook>
References: <149ca41f-9d2c-3e2a-b378-011551e343e9@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <149ca41f-9d2c-3e2a-b378-011551e343e9@molgen.mpg.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 12, 2019 at 02:51:53PM +0200, Paul Menzel wrote:
> On a Dell OptiPlex 5040 with Linux 5.3-rc8, I’ll try to get
> efi-pstore working.
> 
> ```
> $ lsmod | grep efi
> efi_pstore             16384  0
> pstore                 28672  1 efi_pstore
> efivarfs               16384  1
> $ dmesg | grep pstore
> [ 2569.826541] pstore: Using crash dump compression: deflate
> [ 2569.826542] pstore: Registered efi as persistent store backend
> ```
> 
> Triggering a crash with `echo c | sudo tee /proc/sysrq-trigger`,
> there is nothing in `/sys/fs/pstore` after the reboot.
> 
> Please note, that there is also a crash kernel configured, so
> there are actually to reboots, but that should not conflict,
> right?

As long as the crash kernel doesn't delete all the EFI stored variables,
I would expect them to survive.

> Hints on how to debug that would be appreciated. Please find the
> Linux messages attached.

Things seem correct, though I've only done EFI testing under QEMU...
do other things, like BUG (rather than a full panic()) get recorded?
(Maybe try with the lkdtm module?) There was another recent issue with
the "c" sysrq[1] but that seemed to be Xen-specific.

[1] https://lore.kernel.org/lkml/be41da82-3adc-4ab1-e4f9-5fdf11ac4b08@oracle.com/

-- 
Kees Cook
