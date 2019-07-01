Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2348C06508
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 02:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77CE020652
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 02:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2R/ldYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfGACdS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Jun 2019 22:33:18 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:36299 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfGACdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jun 2019 22:33:18 -0400
Received: by mail-pg1-f171.google.com with SMTP id c13so5236254pgg.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2019 19:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=voTuoUFQ5KaHA9/02GEyUejKIGxwvgLp1Lvj8n/za7U=;
        b=d2R/ldYm8Mj0uWNNTMxDFBqHDXXIy/363bp2oqf+P1kkrrgy3/gr808nrwy/TOOwjv
         sIyUHzLcZAPXUVe1TrXscMDs3Ox+yXAhZvzNa/JhAlT5PfSkqtG0ZLSDqL8SvDDPX9Tz
         BSGHi0+RU6f6rJS4qN5ioSuutGmsfLCUYV7TqzMJpxfOxn7D861whFL9PkGJRoPKferC
         IbL9GRimxAf9Qr6HBMq8qrf1RzZUszZrka6xIk3YodtrPg2XyEZHvSGE0Jyt1UKyfTsH
         bRHGlxwskmZV4fKYG6q1RHOz4qMWkrv2R2rbiJ5hdaNHnb9+lwQQN0CL1nrvOhilPkiI
         1ZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=voTuoUFQ5KaHA9/02GEyUejKIGxwvgLp1Lvj8n/za7U=;
        b=EG0aJNAO0HxScnH2n23akTp8Hx9O+rV27ERDAg5o6a0ek+XfgQHlPZIvLdFKEXw7LG
         xu2xZ8yVWHSkUz3s9Ws0po0fXK/wnyYAqmP884EPOMR0AIHsJpZ7TCMjPXg9zrnUf8y7
         RsipjFy88NNqir9LXjlUkDmrTIprEMt+SM0OuhII9aCJcgVNAQXN59KKcD++RiZnOjuJ
         mcdopAJOhM7urQWmbf9/nkarzyMXvfNBdLFLWoqQslCPuhJoq4ALi5tRciVop+cl0RBj
         qPrWnNX48rmdwKT/iSyQ9/3T5wDFzmocEBayLdwqNfF330J+VIuNuvHzNxbnWxXXjSw0
         Nijw==
X-Gm-Message-State: APjAAAXfcMdM5ZKSt2PUfSAyqEDyceMAXPTllX/N1PwR7hWwmz7kO3Yp
        UnbeaV1jyvgsqBYcwYouy9pd89mh
X-Google-Smtp-Source: APXvYqz45LyiB74SXRb5IlkMYJhK6XQUsj4xhlQr19rhEqeZR/UpZjRFD1SD7oHU3Y5qMaVgBdmCgw==
X-Received: by 2002:a63:c34c:: with SMTP id e12mr21430883pgd.195.1561948397231;
        Sun, 30 Jun 2019 19:33:17 -0700 (PDT)
Received: from localhost ([110.70.47.183])
        by smtp.gmail.com with ESMTPSA id h2sm7601838pgs.17.2019.06.30.19.33.15
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sun, 30 Jun 2019 19:33:15 -0700 (PDT)
Date:   Mon, 1 Jul 2019 11:33:12 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Ilia Mirkin <imirkin@alum.mit.edu>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        nouveau <nouveau@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: nouveau: DRM: GPU lockup - switching to software fbcon
Message-ID: <20190701023312.GA4236@jagdpanzerIV>
References: <20190614024957.GA9645@jagdpanzerIV>
 <20190619050811.GA15221@jagdpanzerIV>
 <CAKb7UvhdN=RUdfrnWswT4ANK5UwPcM-upDP85=84zsCF+a5-bg@mail.gmail.com>
 <20190619054826.GA2059@jagdpanzerIV>
 <CAKb7UvgkEXtmJV67EXeBctgaOxM1D91fBbKw9oFMUaB1ZViZQg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKb7UvgkEXtmJV67EXeBctgaOxM1D91fBbKw9oFMUaB1ZViZQg@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/19/19 02:07), Ilia Mirkin wrote:
> If all else fails, just remove nouveau_dri.so and/or boot with
> nouveau.noaccel=1 -- should be perfect.

nouveau.noaccel=1 did the trick. Is there any other, let's say
less CPU-intensive, way to fix nouveau?

	-ss
