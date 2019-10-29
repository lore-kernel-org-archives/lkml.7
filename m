Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2730DC47E49
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6FE721479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572373605;
	bh=6GrFusxXyDjMh/1O0/cmBvl4ctDIO7se0EOtVnn58wo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gk90H6qFVfnfq9+7Kg5EN7yz9SEC1j7tykpmkG3HfLBXF0Cj3k21v+hVTPdbeGLSy
	 JJOojJYoMiaqSTkU+UkaF3YX3x8AZ5WJPd5UghaWD2PUoUinhT6ivaNnGBBrQRJOC0
	 u6jqVqlbW0pKaQqQ+P8Ia38lYCvylqwlTEJymA2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731448AbfJ2S0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:26:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfJ2S0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:26:43 -0400
Received: from mail-yw1-f44.google.com (mail-yw1-f44.google.com [209.85.161.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA18821721
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 18:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572373603;
        bh=6GrFusxXyDjMh/1O0/cmBvl4ctDIO7se0EOtVnn58wo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cGmKY1nZqCLMsj23br8MAnZ5ebcKbgWnXeCEf7kuMXePOD0lpkhuFMDm8nWDton7+
         fAi7iDg8mJKZpue6+f/6LeWsPcz7hFXuJaX1JKJtCmqatE04zjDBBgcoOaNRvtAR3+
         ORbz9mKX1nqSctWp9C8PU8bmFMLqxEC1s9ZxTVO8=
Received: by mail-yw1-f44.google.com with SMTP id g77so5413553ywb.10
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 11:26:42 -0700 (PDT)
X-Gm-Message-State: APjAAAWYd4fBjZq4gCnAtl45PsyglaiyzUcx6oQi1+EG+mmDAS2BSh7O
        3BQvcuXnNUa3ClKl08QB+ZN5jT4SZDiDp2buHg==
X-Google-Smtp-Source: APXvYqxe0cyYS0rpcIKN4B+psqRXIatevBEWQ+yggE1u09NZ+LSCeXtGucKbloYDd1oOdVPJ7pbKjHhhEj684T6V/rc=
X-Received: by 2002:a0d:d307:: with SMTP id v7mr19240164ywd.507.1572373602163;
 Tue, 29 Oct 2019 11:26:42 -0700 (PDT)
MIME-Version: 1.0
References: <20191025134143.14324-1-steven.price@arm.com>
In-Reply-To: <20191025134143.14324-1-steven.price@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Oct 2019 13:26:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJC8PJqKhsLBUw6COgUyLG7DYV77B8W_XYrKS4CwcY-wQ@mail.gmail.com>
Message-ID: <CAL_JsqJC8PJqKhsLBUw6COgUyLG7DYV77B8W_XYrKS4CwcY-wQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] drm/panfrost: Tidy up the devfreq implementation
To:     Steven Price <steven.price@arm.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2019 at 8:41 AM Steven Price <steven.price@arm.com> wrote:
>
> The devfreq implementation in panfrost is unnecessarily open coded. It
> also tracks utilisation metrics per slot which isn't very useful. Let's
> tidy it up!
>
> Changes since v1:
>  http://lkml.kernel.org/r/20190912112804.10104-1-steven.price%40arm.com
>  * Rebased onto latest drm-misc-next, specifically after
>    d18a96620411 ("drm/panfrost: Remove NULL checks for regulator")
>  * Added tags
>
> Steven Price (2):
>   drm/panfrost: Use generic code for devfreq
>   drm/panfrost: Simplify devfreq utilisation tracking

Series applied.

Rob
