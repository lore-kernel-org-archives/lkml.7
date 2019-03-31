Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB1AC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5045D20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABCm/x8D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731191AbfCaMS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:18:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53819 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbfCaMS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:18:56 -0400
Received: by mail-wm1-f67.google.com with SMTP id q16so7237517wmj.3;
        Sun, 31 Mar 2019 05:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1TvPgJgdAqjN0RPKxN+C/tRXajhzKUiElOZVOUrfgMM=;
        b=ABCm/x8DP6SbinEcOdM5oPy9botOYe15MMBRroEU1PAbYmIiQGeOJmEGg6wFbkjVtR
         xm0kWMd7Mio135qu7rQFA47RMn73FILCxiITr8BA8uNLBQ8+98HtrvyHPITr6O3aA8yn
         qclKGDvyYGLdKzyg4FtJ43obff0/S9PbRIr8o6/6r/WaEFLQJQetF2HVdpLm59G6xL/y
         Z3knbJJnjQPMBpe2NqhDSFRhSqJZSjmYY4n25P9ZzbmpOWUzwR2PQYQNJowQPIWMjRZ9
         tECnynxGOZNILQPeNwm1shZlTZ/mKY8jwaMV8zVdi31TygGpOD+TPX5LG8RLEhrLI+XP
         ydXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1TvPgJgdAqjN0RPKxN+C/tRXajhzKUiElOZVOUrfgMM=;
        b=ECw78NLdqnlVF72FWlja7sHNF/zMqjOtPK4c2U0VL0LSCilEJvDtT2zZqiAGVObtf7
         w+/bT7LipcbAhipLE0LmEuUH0GyJo1VDehGgP18BwPeL6N9CxG4Ow3PfMZ0p0ob8v6nG
         poGi8T+jYuk0dlhYVTPLjA1x2lbeczLOUnpnWoyk32qBzlY7YqBiu2O/SJbLUj0dBvhI
         9VnCEvcYR7cQQ/0mPWJqVR8sDpLmWXnYJiuLn7RFw9G4XSrGIqtDB1VL5W7MlbX8Fz8j
         3EVxOYVJVRDhbiq/aPIn6kTPpQSSOaGGliUnrdYYtk553v+I8/Ub3uQ4zzVByvJhQO17
         6WDg==
X-Gm-Message-State: APjAAAUrwK7Ig9fip2jcQ4KVI8BzPa6z3e9kvE+EQhgk7R4LecogmKNS
        u9zVxOK66n/QS7bqZseqhiw=
X-Google-Smtp-Source: APXvYqx4kCVbwMYfJsSxk+NYD0NgFV8+RZOQ1mV36mZqaVZ0g7xn7nVxMekXjrwk7RGwrxcWNAlzuw==
X-Received: by 2002:a7b:cf2b:: with SMTP id m11mr6924649wmg.56.1554034734285;
        Sun, 31 Mar 2019 05:18:54 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id x205sm3322953wmg.9.2019.03.31.05.18.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 05:18:53 -0700 (PDT)
Date:   Sun, 31 Mar 2019 13:18:51 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/8] fbdev: sm712fb: fix white screen of death on reboot,
 don't set CR3B-CR3F.
Message-ID: <20190331121851.h3j2pud6yhelsknr@debian>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-2-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316222504.27170-2-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 06:24:57AM +0800, Yifeng Li wrote:
> On a Thinkpad s30 (Pentium III / i440MX, Lynx3DM), rebooting with
> sm712fb framebuffer driver would cause a white screen of death on
> the next POST, presumably the proper timings for the LCD panel was
> not reprogrammed properly by the BIOS.
> 
> Experiments showed a few CRTC Scratch Registers, including CRT3D,
> CRT3E and CRT3F may be used internally by BIOS as some flags. CRT3B is
> a hardware testing register, we shouldn't mess with it. CRT3C has
> blanking signal and line compare control, which is not needed for this
> driver.
> 
> Stop writing to CR3B-CR3F (a.k.a CRT3B-CRT3F) registers. Even if these
> registers don't have side-effect on other systems, writing to them is
> also highly questionable.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
