Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459BAC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B8D20870
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9IF1x83"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731236AbfCaMTu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:19:50 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:40300 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbfCaMTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:19:49 -0400
Received: by mail-wm1-f67.google.com with SMTP id z24so8063991wmi.5;
        Sun, 31 Mar 2019 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xSybAyrdLw33vq1UDxnMPu9wvEFTX4RtzrE5Btn6TvY=;
        b=h9IF1x83Fwjt+Vi0OjRqFq0xysg94YuVtk8OaJ8D/X9jcJ0f0e8983EqqKIGxTMIWE
         gX1IxoACzbbIWSAxTcbBgY8kRg57jeANYJnq510AAdouSqTTPuIbKyxQJi5sTmjIr4xV
         M9GkmPF1EfSgW549y5Z/JH06JP7teT0T4zaQJSEiFI7ZFfrI6G8rkYGma9ZKWewmbw8z
         mGmcQi+6MExP+9oyhM0jCSRMH/jndLRYsk5GEK+YLSI5z8BWwnxP9wqJ5AmNBlxin8oK
         zj361V4S0ElvqLNzk8RVWo8yVsxJnZQD7hh3IlEW5+z91PTMrK/OcEDnCjTDyXHYFRwU
         ChAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xSybAyrdLw33vq1UDxnMPu9wvEFTX4RtzrE5Btn6TvY=;
        b=NiHGjOSSvzPq9GU3O98jXwYPq2vFQHkyjZJziE9oVrTUK6SiPxQvXIEkNI7fGABOPZ
         2cOPkdJtCoINPETBodPdi4alTyBQQRta6QXjg81HcVZtAnb4OIpqvX4N12OGFjiOEyQW
         O6pJaO/JEqJF9j3p7Q1+NRtgq6Fs2sznns3PwyA4CmF//pUsP8tOGwBGqqxErQI3Zm3K
         rh9YmPDA493r+FXkr/ECYO7ZUfbm5T2k2l0LWo4V7JOv7X2l0MMs6O1NzVA0KqRB29ja
         yorIyjQ+9ShUMgt6N/g/TQG3FRuXdw3fbwDXNe0eHZV6E1rUfL2iPfvIkZc0wiMKvPDU
         W6Ww==
X-Gm-Message-State: APjAAAXvXYZSGfaC1IDj7WuYR/qZpmBA+zsKrjpbE6luTT0NJPhC3or4
        zCsska0lF4DXLlnxHMhdP6xUhkMRf0w=
X-Google-Smtp-Source: APXvYqyJ2ya3e8KyEEgOZQYGyDc2MFFP2bpt426bbaFcOst/EsmzLhJgN6KnRJl0ueGkrtCHWSINGw==
X-Received: by 2002:a1c:808c:: with SMTP id b134mr9586016wmd.16.1554034787556;
        Sun, 31 Mar 2019 05:19:47 -0700 (PDT)
Received: from debian (cpc101300-bagu16-2-0-cust362.1-3.cable.virginm.net. [86.21.41.107])
        by smtp.gmail.com with ESMTPSA id i28sm24179166wrc.32.2019.03.31.05.19.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 31 Mar 2019 05:19:46 -0700 (PDT)
Date:   Sun, 31 Mar 2019 13:19:44 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Yifeng Li <tomli@tomli.me>
Cc:     Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 4/8] fbdev: sm712fb: fix boot screen glitch when sm712fb
 replaces VGA.
Message-ID: <20190331121944.s67z7seyrgl5xnrw@debian>
References: <20190316222504.27170-1-tomli@tomli.me>
 <20190316222504.27170-5-tomli@tomli.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190316222504.27170-5-tomli@tomli.me>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 17, 2019 at 06:25:00AM +0800, Yifeng Li wrote:
> When the machine is booted in VGA mode, loading sm712fb would cause
> a glitch of random pixels shown on the screen. To prevent it from
> happening, we first clear the entire framebuffer, and we also need
> to stop calling smtcfb_setmode() during initialization, the fbdev
> layer will call it for us later when it's ready.
> 
> Signed-off-by: Yifeng Li <tomli@tomli.me>
> Cc: stable@vger.kernel.org  # v4.4+

Tested-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

--
Regards
Sudip
