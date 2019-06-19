Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE4EC31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D25208CB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 10:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Me285Eft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731136AbfFSKeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 06:34:20 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51735 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfFSKeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 06:34:19 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so1171968wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 03:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=urGhGMBj9Gj+93Uz4bCVBFsm8sW6q9N7nifD7I3Dmm0=;
        b=Me285EftGAvkCIm9KR5xzgD/NL8izuvygR9J344xkydeliRaRPW5ey628RjJ9Mou79
         LRJXCQjIuWJqhr/4KPcqV+ZZpgVZ0/ELnk0cchhFVf6V9uOdGdr16KW0EhYSuSLVZ3jL
         ZRPYdouYLdWf+/VQReZpSzJJ3dWE/W1hyzpsxY5j/M9i1NqzGEvDjICgsyhCkPul+QV3
         hM1Y7gnHrBQV7S3v5ibr7kqQm8YsXvPnOwodmB0P7yUzHmOkHBnQOsst4iWGPu1/H2J7
         deHamS/6KyEiSgtA+ZaorzjLg+TeKkoJ3v9NZHOZ8szBo6X1aZyMt7+xBk55Oufo7lI3
         Hkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=urGhGMBj9Gj+93Uz4bCVBFsm8sW6q9N7nifD7I3Dmm0=;
        b=ac2K1HFweZ49glHmhAwAL9OdTaSoZspwdSDnY/hgFjJ81X/w+svj5WBOWRYS4e4env
         nsQku3qwMscuaDGtGvVqYK23l08UFMahksvrHIwIE1LQkYPzYFl6hKxhNh+C+NmqqD+H
         kKMlMHE6O/UpCOvtACp5nXyCtFxt8xNjmPHf8X4rNZdl28pn6dQVBoLzzBWdeTfYv+Xz
         JxsSH3yUotdnwuWT++K34YmFwRVVK8FRkGWzU4Lr8zDUGe+E7VHKGMkxIWa1Do9arGS7
         awIIqsQexN3PwhcUgUqXLXL9SoXLiNfk3mygTJR8qRX7Y/p8PSxrfhLEk1OnhlyLrrYY
         DuQQ==
X-Gm-Message-State: APjAAAURmA1Z7+DqTCm6VBn5xygLcz6QWBTbb1dFzT8s2qEcZ4qh1juT
        f/5tZHHjwHs0vz0H1ocGNYgtzqhM
X-Google-Smtp-Source: APXvYqxlJa5H3ubJWUsDp+ynl4+d24K8AumjDor4n6joXgVyOU36lrWHz8h2zbzlmxQFjprEYnnp3w==
X-Received: by 2002:a1c:a186:: with SMTP id k128mr7944693wme.125.1560940457198;
        Wed, 19 Jun 2019 03:34:17 -0700 (PDT)
Received: from arch-x1c3 ([2a00:5f00:102:0:9665:9cff:feee:aa4d])
        by smtp.gmail.com with ESMTPSA id w67sm1417860wma.24.2019.06.19.03.34.16
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 03:34:16 -0700 (PDT)
Date:   Wed, 19 Jun 2019 11:32:12 +0100
From:   Emil Velikov <emil.l.velikov@gmail.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v3 01/12] drm: add gem array helpers
Message-ID: <20190619103212.GA1896@arch-x1c3>
References: <20190619090420.6667-1-kraxel@redhat.com>
 <20190619090420.6667-2-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190619090420.6667-2-kraxel@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gerd,

On 2019/06/19, Gerd Hoffmann wrote:

> +/**
> + * drm_gem_array_from_handles -- lookup an array of gem handles.
> + *
> + * @drm_file: drm file-private structure to use for the handle look up
> + * @handles: the array of handles to lookup.
> + * @nents: the numer of handles.
> + *
> + * Returns: An array of gem objects on success, NULL on failure.
> + */
> +struct drm_gem_object_array*
> +drm_gem_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents)
> +{
> +	struct drm_gem_object_array *objs;
> +	u32 i;
> +
> +	objs = drm_gem_array_alloc(nents);
> +	if (!objs)
> +		return NULL;
> +
> +	for (i = 0; i < nents; i++) {
> +		objs->objs[i] = drm_gem_object_lookup(drm_file, handles[i]);
> +		if (!objs->objs[i]) {
Missing object put for the 0..i-1 handles. Personally I would:
    objs->nents = i;
    drm_gem_array_put_free(objs);
    return NULL;

> +			drm_gem_array_put_free(objs);
> +			return NULL;
> +		}
> +	}
> +	return objs;
> +}
Missing EXPORT_SYMBOL?

> +
> +/**
> + * drm_gem_array_put_free -- put gem objects and free array.
> + *
> + * @objs: the gem object array.
> + */
> +void drm_gem_array_put_free(struct drm_gem_object_array *objs)
> +{
> +	u32 i;
> +
> +	for (i = 0; i < objs->nents; i++) {
> +		if (!objs->objs[i])
> +			continue;
> +		drm_gem_object_put_unlocked(objs->objs[i]);
> +	}
> +	drm_gem_array_free(objs);
> +}
Ditto?

HTH
Emil
