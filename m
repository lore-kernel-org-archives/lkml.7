Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56955C10F14
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1734020833
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 02:59:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMipgTXX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfDVC7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 22:59:03 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33298 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfDVC7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 22:59:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id k19so5191047pgh.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2019 19:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bLTCqZP0EkEe5cTjpvrGXCdlUzTPZuSYTCe6QDTNd9Q=;
        b=WMipgTXX23x09PQjGeptEst4JHIS05wIXfC9NKFO/azh/ELjjw7eRT1JP2Xnl51o42
         F7Ew4z7pbyWDOLspFgzi79/5QSpm0C+OmtsIYtqg4EryaTngcEvHHTTHjf1jTqHmZKxf
         LYScnE8+ZmjWvHMeJUJwEKIuZjwlDn4d0hEX1dKSaigOshR1j8Wh0YUy+kt8s1ZFNNVM
         jgtnV9G3Zze+c3TlclbBRhZYvTLAsWw1dxrT8SyI5tSrgY2nD+Rm1lWlOi8QI5om60bY
         6SiMCEZJX7hsHryQt4x2dj4CcGyjO88/plKhfgKYA/0VI7e3fHq2bRC9xLdf9mtN5R+/
         Ibtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bLTCqZP0EkEe5cTjpvrGXCdlUzTPZuSYTCe6QDTNd9Q=;
        b=Z6NX9hW206n1XcsKPH6CfYnFpsp/tJnsb17eT1AgP4IOixyFfJ0cORtqRnX+JqywLN
         fPpg3JkgpGB977LygpmH/39RfgFd0KYJzO0W/vyOvu/Wm8Lpvks9t1pURV3NzoCgHbbw
         CZO6G3eOy50WoGHd6hYsOIMT2VeebEJ/ii37owejJLWW+zphiTkb40LJoCMYqJ3JnUEh
         DqzL90y/ousagjlpyPcBmgUhEL5SkWSHt4SEvuNklhxBYaRntVeMWTm8ykoO6PYE1zXj
         ry67FDTiEyTfRyhaT2OkqDtes8yNIesLtU4CFJNBQqc60fqWVJLAt4eMLDoBQ0d5x7wI
         Z0nQ==
X-Gm-Message-State: APjAAAX5JUNmKhe3WvYEx4ShLb95vsm945z9MMdG9cjYM6zjPI0bobCI
        f1GXjVQQOfsNZ1GCNEJ9WNY=
X-Google-Smtp-Source: APXvYqx/X7l9wCZA8zKnCu4okFTzhlOhU2FcDFA2JwYv8oCTRTXnlBX2TyBzxH6e/EpmwhE73FZOig==
X-Received: by 2002:a62:5206:: with SMTP id g6mr17639111pfb.227.1555901942422;
        Sun, 21 Apr 2019 19:59:02 -0700 (PDT)
Received: from Asurada (c-98-248-47-108.hsd1.ca.comcast.net. [98.248.47.108])
        by smtp.gmail.com with ESMTPSA id b63sm30188611pfj.54.2019.04.21.19.59.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Apr 2019 19:59:01 -0700 (PDT)
Date:   Sun, 21 Apr 2019 19:58:55 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     "S.j. Wang" <shengjiu.wang@nxp.com>
Cc:     "timur@kernel.org" <timur@kernel.org>,
        "Xiubo.Lee@gmail.com" <Xiubo.Lee@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 3/3] ASoC: fsl_asrc: Unify the supported input and
 output rate
Message-ID: <20190422025854.GA8476@Asurada>
References: <cover.1555900078.git.shengjiu.wang@nxp.com>
 <841aa2c4256e418759422affe6c138fa55cd1785.1555900078.git.shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <841aa2c4256e418759422affe6c138fa55cd1785.1555900078.git.shengjiu.wang@nxp.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2019 at 02:32:38AM +0000, S.j. Wang wrote:
> Unify the supported input and output rate, add the
> 12kHz/24kHz/128kHz to the support list
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

Thank you
