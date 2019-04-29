Return-Path: <SRS0=c0gK=S7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136C5C43219
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:55:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5801214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Apr 2019 06:55:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="FodnkuEm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727481AbfD2Gzs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Apr 2019 02:55:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46484 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfD2Gzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Apr 2019 02:55:48 -0400
Received: by mail-lf1-f66.google.com with SMTP id k18so6928407lfj.13
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2019 23:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X79SrIi9c84VIrWeeLGrqQgrBJdkT4fyXXb11dpl5ZI=;
        b=FodnkuEmqqVuaM5mDPGWUCZOn1baCfEeqTxi+dIxUzLDrZXO/0mZGmUBicyEW2dam0
         shxT1VNv2cNfeI7a9gkdE3unft2FW4c7F86WvbDabsMHDoUb3W94Q3XfHuIgshSTU6uD
         cTCSIL50Kh7ocMBdk//GsoX7dWi2Iv3w8hZoKgl5DF/7HJqMzHcc3duWAV+RU25LhPHG
         cVH3isgjjR+o0f1ZvO9oo/n/ac5xSx8zIJgynE49YLoc4SR2JLZzylh76xAHDMGCAs74
         uurHec8CRsvdUTvr1jxGLIJknMQC1qiMVaiQYHA4lHUdmgptwIU69etDvrmsoyRI5LRm
         TGxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X79SrIi9c84VIrWeeLGrqQgrBJdkT4fyXXb11dpl5ZI=;
        b=A2WgG+PiDw0UUCXeKzmjF8vCJMILUDqlmBbW86TcAtefdaaUpvpZ7KYib9jqplDojk
         ntszk5sFRR7yNysgJHOqYrFYxhnFazjGYlxbFpVs8kb2l7l9Vfs0K8/uMnEgpfxAaLrY
         FcBy8ApPLIuu9o4qVJ6jtTBVXcDQAp6WxV7XZJW6jjgSbvy5wy45/0yBOmOGnSE1ab4i
         okEfltWdqolGlem2Y20ypCyomFC5OYslE7cjSSui6qqUzBHMiJ+cAQwLgPhxZbiNgfQ5
         87xjU98fT0hPJso138XTYZyADaK700GCM8C67CJhXYBQcthH2vEXV1JVpKE0BDo/sONq
         zg/w==
X-Gm-Message-State: APjAAAULK1AUjNb5mYnRg5vCtAC4ohk0+PLcXTNhPwli2m4JcWPNowP2
        vMXofn8V6IltbIu/sCs0IRMPfw==
X-Google-Smtp-Source: APXvYqz2HI1dJLQ6NTVZVazrEaO9tcW9JY+dPMoexZcD6xY339/BeCzOPtYhoZrEh0iSOaLVtwy66g==
X-Received: by 2002:ac2:51a1:: with SMTP id f1mr22068165lfk.129.1556520946405;
        Sun, 28 Apr 2019 23:55:46 -0700 (PDT)
Received: from localhost (h85-30-9-151.cust.a3fiber.se. [85.30.9.151])
        by smtp.gmail.com with ESMTPSA id d16sm7204946lfi.75.2019.04.28.23.55.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 28 Apr 2019 23:55:45 -0700 (PDT)
Date:   Sun, 28 Apr 2019 23:19:42 -0700
From:   Olof Johansson <olof@lixom.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        marc.w.gonzalez@free.fr, john.stultz@linaro.org,
        liwei213@huawei.com
Subject: Re: [PATCH] arm64: defconfig: Update UFSHCD for Hi3660 soc
Message-ID: <20190429061942.2e3xy3ki7ua5woai@localhost>
References: <20190416170221.13764-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190416170221.13764-1-valentin.schneider@arm.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 16, 2019 at 06:02:21PM +0100, Valentin Schneider wrote:
> Commit 7ee7ef24d02d ("scsi: arm64: defconfig: enable configs for Hisilicon ufs")
> set 'CONFIG_SCSI_UFS_HISI=y', but the configs it depends
> on
> 
>   (CONFIG_SCSI_HFSHCD_PLATFORM && CONFIG_SCSI_UFSHCD)
> 
> were left to being built as modules.
> 
> Commit 1f4fa50dd48f ("arm64: defconfig: Regenerate for v4.20") "fixed"
> that by reverting to 'CONFIG_SCSI_UFS_HISI=m'.
> 
> Thing is, if the rootfs is stored in the on-board flash (which
> is the "canonical" way of doing things), we either need these drivers
> to be built-in, or we need to fiddle with an initramfs to access that
> flash and eventually load the modules installed over there.
> 
> The former is the easiest, do that.
> 
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Applied, thanks!


-Olof
