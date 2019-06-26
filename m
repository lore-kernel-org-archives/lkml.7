Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE69C48BD9
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4F77208E3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 21:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="cgLAV+Rp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfFZV1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 17:27:40 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43628 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbfFZV1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 17:27:39 -0400
Received: by mail-ed1-f66.google.com with SMTP id e3so5009065edr.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 14:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=sender:date:from:to:cc:subject:message-id:mail-followup-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=UrjR3DDihkVtErCxXsK+ErOLFwWfcE9m/qcnzk09UyY=;
        b=cgLAV+Rp6zbNz1nb64bmt0RkKhKMJQ9aqc+CMUU2XUHSBJQ6pHvdXE3dH36q6wAchh
         Wt67WeRnz1HwvYQNsaJhuip9yFw8HMEiia1oFayPRFAuERJEJUTYeRRQkWQID7etjTds
         LnUtOuywRKbB0Nr0sH+C5YmuQkPnrTfL6aExg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=UrjR3DDihkVtErCxXsK+ErOLFwWfcE9m/qcnzk09UyY=;
        b=uA0vDca44+n/WGyX8BBBtq3LbxMdJ/vBm8nLMeunMyrHVeVsPtl/MmndbPYF8mDT8w
         Qcem7jtAFLRvjcIPkL+WcdoIUEhxzfdInixPgUFhdArYai3fHTI9h6JOpuCGbuFfqmoE
         nLz3yhM1LUlIp8+Xr/7UOje0y1bnOo12yCanpteoZa1x7ynZOCJbPs3ePVJR2eWWiqiP
         WLdztcEB16lyB/f/YAG5aKaYwIp2ydPo0DMLXKY9fIgvHpNOHYQrzDWiKf94z0SRmAoi
         G29fQVFDlK+ZESkaZmT2E2beirbR/Tsg/VJQL2lfIMRHoThZYR8HJfwNdQES/DOOVDDB
         sQ0g==
X-Gm-Message-State: APjAAAVeTB3vWnVeVmSdmGeWyC5P12HawCEs2jbY5nhQd561/LmWEShn
        bLgyFLky7ekW9yRRitCoXj9v9w==
X-Google-Smtp-Source: APXvYqzR0IbAROk3gpDamYKJeT+OF9uZlY5ZEmOadbWZJftZuRBhsscuB56FYYJd7NYuf1+9vgy3TA==
X-Received: by 2002:a17:906:6d2:: with SMTP id v18mr6059151ejb.279.1561584458203;
        Wed, 26 Jun 2019 14:27:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:569e:0:3106:d637:d723:e855])
        by smtp.gmail.com with ESMTPSA id q50sm27042edd.91.2019.06.26.14.27.36
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 26 Jun 2019 14:27:37 -0700 (PDT)
Date:   Wed, 26 Jun 2019 23:27:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: fix a reference for a renamed file: fb/modedb.rst
Message-ID: <20190626212735.GY12905@phenom.ffwll.local>
Mail-Followup-To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
References: <699d7618720e2808f9aa094a13ab2f3545c3c25c.1561565652.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <699d7618720e2808f9aa094a13ab2f3545c3c25c.1561565652.git.mchehab+samsung@kernel.org>
X-Operating-System: Linux phenom 4.19.0-5-amd64 
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 26, 2019 at 01:14:13PM -0300, Mauro Carvalho Chehab wrote:
> Due to two patches being applied about the same time, the
> reference for modedb.rst file got wrong:
> 
> 	Documentation/fb/modedb.txt is now Documentation/fb/modedb.rst.
> 
> Fixes: 1bf4e09227c3 ("drm/modes: Allow to specify rotation and reflection on the commandline")
> Fixes: ab42b818954c ("docs: fb: convert docs to ReST and rename to *.rst")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>

What's the merge plan here? doc-next? If so:

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_modes.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 57e6408288c8..4645af681ef8 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -1680,7 +1680,7 @@ static int drm_mode_parse_cmdline_options(char *str, size_t len,
>   *
>   * Additionals options can be provided following the mode, using a comma to
>   * separate each option. Valid options can be found in
> - * Documentation/fb/modedb.txt.
> + * Documentation/fb/modedb.rst.
>   *
>   * The intermediate drm_cmdline_mode structure is required to store additional
>   * options from the command line modline like the force-enable/disable flag.
> -- 
> 2.21.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
