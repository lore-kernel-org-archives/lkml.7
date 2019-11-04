Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0128CA9ECF
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC1D20869
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 18:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="fn+K0Jeb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729566AbfKDSTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 13:19:39 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43408 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728336AbfKDSTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 13:19:39 -0500
Received: by mail-wr1-f68.google.com with SMTP id n1so18248139wra.10
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 10:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Qfg3/OhENOhgHzvHvbxDHTYQ7dgyHpgpR3Q3h/hLkOE=;
        b=fn+K0JebeyPggpWIrakbcYMmMywkz8WCAdLPRUAUoAtqIBUspiPN7tD3QProjEFSDP
         nLRQVnCWYlJKioXnZylDFjZ9CvozxWOKgd65NLtZqd17WmgPpSzRe+AzdbWMQMwiKEAh
         Qm0FkocWIVWPD+J6wOxMRhwzLkNS66oy4IFOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Qfg3/OhENOhgHzvHvbxDHTYQ7dgyHpgpR3Q3h/hLkOE=;
        b=i3xalsiqDZAeRcuV+lsGuGz1qBNAjO4TK+3MX60GIrMzPr62Y7m/bxSzsgU72yxvbZ
         jYrrtqzMSZLvyTKTR6WModuAuJz5B8JnxAQB6dbVmYRtMvPzis014Y52b5aiQnYQAsxq
         B0xBUc2RFJetGZoXZKGUPt4mRHP8NmACVz6Jun6CJpm55EGGF5/rUMKJqKwvEQ4g/fOd
         FcLJagohgRT/Y6UXsl2PC0EGFL3GREGTbKK2V0DeIeAMRYSbAAy/k6KsDrwATovrP6Hk
         JvTOYKvrR44JRlb3WE7ViDlAqJwoQ9fQwVlz5O26i0DxluRLLLlRh5tYo7/aeMFLOIEd
         ydvw==
X-Gm-Message-State: APjAAAX0DwkvG3SH9Virlf7ppcgbseSywrGWAmu4nypg19LU+vTGQfHV
        F+gmv8TGqhBcv4rK3sr1qMl+mQ==
X-Google-Smtp-Source: APXvYqzyNg3sXHFnQDm+gajzHEmP+Sqmi0HVIhd7GKvcRWFfi/tYWvfUdKRE7PACl7E/z0xmll/zhg==
X-Received: by 2002:adf:f70f:: with SMTP id r15mr25585980wrp.262.1572891576303;
        Mon, 04 Nov 2019 10:19:36 -0800 (PST)
Received: from phenom.ffwll.local (212-51-149-96.fiber7.init7.net. [212.51.149.96])
        by smtp.gmail.com with ESMTPSA id p12sm19639397wrm.62.2019.11.04.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2019 10:19:35 -0800 (PST)
Date:   Mon, 4 Nov 2019 19:19:33 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Cc:     outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run, airlied@linux.ie,
        daniel@ffwll.ch, corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] drm/doc: Adding VKMS module description and use to
 "Testing and Validation"
Message-ID: <20191104181933.GR10326@phenom.ffwll.local>
Mail-Followup-To: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        outreachy-kernel@googlegroups.com, manasi.d.navare@intel.com,
        rodrigosiqueiramelo@gmail.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, sean@poorly.run, airlied@linux.ie,
        corbet@lwn.net, dri-devel@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
References: <20191101042706.2602-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101042706.2602-1-gabrielabittencourt00@gmail.com>
X-Operating-System: Linux phenom 5.2.0-3-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 01, 2019 at 01:27:06AM -0300, Gabriela Bittencourt wrote:
> Add a description on VKMS module and the cases in which it should be used.
> There's a brief explanation on how to set it and use it in a VM, along with
> an example of running an igt-test.
> 
> Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
> 
> ---
> 
> Hi DRM-community,
> this is my first (of many, I hope)  patch in this subsystem. I hope to have
> a lot of learning (and fun :)) working with you guys.
> I'm starting by documenting the VKMS driver in "Userland interfaces", if I
> have been inaccurate in my description or if I misunderstood some concept,
> please let me know.

Oh awesome, this sounds great, really looking for more people hacking on
vkms. Docs lgtm, but I'll let Siqueira have a look and merge it. Pls ping
in case this patch gets lost.
-Daniel


> ---
>  Documentation/gpu/drm-uapi.rst | 38 ++++++++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-uapi.rst b/Documentation/gpu/drm-uapi.rst
> index 94f90521f58c..7d6c86b7af76 100644
> --- a/Documentation/gpu/drm-uapi.rst
> +++ b/Documentation/gpu/drm-uapi.rst
> @@ -285,6 +285,44 @@ run-tests.sh is a wrapper around piglit that will execute the tests matching
>  the -t options. A report in HTML format will be available in
>  ./results/html/index.html. Results can be compared with piglit.
>  
> +Using VKMS to test DRM API
> +--------------------------
> +
> +VKMS is a software-only model of a KMS driver that is useful for testing
> +and for running compositors. VKMS aims to enable a virtual display without
> +the need for a hardware display capability. These characteristics made VKMS
> +a perfect tool for validating the DRM core behavior and also support the
> +compositor developer. VKMS helps us to test DRM core function in a virtual
> +machine, which makes it easy to test some of the core changes.
> +
> +To Validate changes in DRM API with VKMS, start setting the kernel. The
> +VKMS module is not enabled by defaut, so enable it in the menuconfig::
> +
> +	$ make menuconfig
> +
> +Compile the kernel with the VKMS enabled and install it in the target
> +machine. VKMS can be run in a Virtual Machine (QEMU, virtme or similar).
> +It's recommended the use of KVM with the minimum of 1GB of RAM and four
> +cores.
> +
> +It's possible to run the IGT-tests in a VM in two ways:
> +1. Use IGT inside a VM
> +2. Use IGT from the host machine and write the results in a shared directory.
> +
> +As follow, there is an example of using a VM with a shared directory with
> +the host machine to run igt-tests. As example it's used virtme::
> +
> +	$ virtme-run --rwdir /path/for/shared_dir --kdir=path/for/kernel/directory --mods=auto
> +
> +Run the igt-tests, as example it's ran the 'kms_flip' tests::
> +
> +	$ /path/for/igt-gpu-tools/scripts/run-tests.sh -p -s -t "kms_flip.*" -v
> +
> +In this example instead of build the igt_runner it's used Piglit
> +(-p option); it's created html summary of the tests results and it's saved
> +in the folder "igt-gpu-tools/results"; it's executed only the igt-tests
> +matching the -t option.
> +
>  Display CRC Support
>  -------------------
>  
> -- 
> 2.20.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
