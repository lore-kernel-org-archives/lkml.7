Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEB1C76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 07:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F91E205F4
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 07:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJmPgxcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbfGUHYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 03:24:32 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34580 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfGUHYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 03:24:32 -0400
Received: by mail-lf1-f65.google.com with SMTP id b29so17171711lfq.1;
        Sun, 21 Jul 2019 00:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/nSIcquNpPyNnZ7DklkJMd6V9hdvNBFGl3lMPzNM4NU=;
        b=bJmPgxcFVupOQf/vSmJM/dH3zfqFjfLjzBujbSs+uWa9AWUKY6gakLh3AZM6/DevUg
         WFF3jP8aJiWaDWiXUQp7gozDaJdUNI/WCHHpjBc9tG/j5rWmaFGl0rGZ2uMIzBUEesB+
         dQKlSt8B2lqQCsCp7YVGAJISsMgXioLJsbhLoAJGJJPgLeEaS9Mfm6cKMftvo1dJ9jIg
         RcVQNUeBVWqfGH/qRrO9+FsadGceW3s55TPYWyEnd86If9k3XoOISzcxbi9xSE/Ijy3+
         VBneTeV+gQJ4Hs3my5dYqUMcKViRRCOO3O0Bg4JralZTDY9KU9v5wg22rjisw6ufii/U
         SfDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/nSIcquNpPyNnZ7DklkJMd6V9hdvNBFGl3lMPzNM4NU=;
        b=bHDmo6AOYdZbC83q4q3G6Na4lMGuUf8LZe15PRjzTx5bRU9ZRN8rwIl5FNBMVvwMV1
         FuhKVMFCxjfOf2CqGFBlAr8DawQlN2k4IUu002IJ+uWUJBQidOib+K5kHnsv0uCtoPwY
         U8941NL6zAUOMomyWGrOPZhCs3ocTWmv6qa8OufMAbqWq8CTouSFeSNkgRJrWx5zBpa9
         O7k4v4SHmRFl15p2nBzH2kXyAlhGH+L/izqrMt/Bu/OkNBUGzjVmRLYCJfTL3EKSjIXR
         LFGllR/E4jHXPpdxLTzQh5mBkQlWgizHycYR2zbbkmZs3Yo1w54icR3swqWBB5jAquyF
         I1mw==
X-Gm-Message-State: APjAAAVrYF55f98ne+IU0OyBFXtk8nxu+xU/r0f0hLDLwMQIWYFkXFmx
        HBz5qwNbMFAnJl5hgkPEFMc=
X-Google-Smtp-Source: APXvYqzogpHs0HCbIF8sYFuXTGSa0tXVlh8eIoez3hAAsIjdXkMqRY7vQUP+9gKIU3a9RFJHmetCag==
X-Received: by 2002:a19:ae0d:: with SMTP id f13mr28105098lfc.123.1563693870470;
        Sun, 21 Jul 2019 00:24:30 -0700 (PDT)
Received: from localhost ([188.170.223.67])
        by smtp.gmail.com with ESMTPSA id k27sm6152939lfm.90.2019.07.21.00.24.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Jul 2019 00:24:29 -0700 (PDT)
Date:   Sun, 21 Jul 2019 10:24:27 +0300
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Ronald =?iso-8859-1?Q?Tschal=E4r?= <ronald@innovation.ch>
Cc:     Federico Lorenzi <federico@travelground.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] Input: applespi: fix warnings detected by sparse
Message-ID: <20190721072427.GB607@penguin>
References: <20190721070629.24932-1-ronald@innovation.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190721070629.24932-1-ronald@innovation.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 12:06:29AM -0700, Ronald Tschalär wrote:
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Ronald Tschalär <ronald@innovation.ch>
> ---
>  drivers/input/keyboard/applespi.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/input/keyboard/applespi.c b/drivers/input/keyboard/applespi.c
> index d5defdefbc34..00cd8dccd4f5 100644
> --- a/drivers/input/keyboard/applespi.c
> +++ b/drivers/input/keyboard/applespi.c
> @@ -998,10 +998,14 @@ static inline int le16_to_int(__le16 x)
>  static void applespi_debug_update_dimensions(struct applespi_data *applespi,
>  					     const struct tp_finger *f)
>  {
> -	applespi->tp_dim_min_x = min_t(int, applespi->tp_dim_min_x, f->abs_x);

Should we also make tp_dim_* u16? Then we won't need min_t here.

-- 
Dmitry
