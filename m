Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91B77C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6471B20870
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567671699;
	bh=JFwtoixLuRX1yZtp0YeGec+QR58HWNl8zjVOsKByQsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ISeX3rS71qvGEeK1cvR3keAQZgBhOth9baEcxYXUar3AWn1vOVe7d0vWSN/S8zy93
	 cF25STkUPW5n7WF/HaNsvD/4OM864KonQ26YGv85FxmABB8q9+SjU5LUD/jjagK58r
	 LoSmmyAfoizFTDJE3UOyWvUMwcd9n1aR2I6CcVFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732565AbfIEIVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:21:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbfIEIVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:21:38 -0400
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EBC121848
        for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2019 08:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567671697;
        bh=JFwtoixLuRX1yZtp0YeGec+QR58HWNl8zjVOsKByQsM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X5lZboRCCXqovxducQamdVD/sqmML6m7jOMA77uilL9WBg5nVp4sUCvBgD+09ps7S
         0s40DNA4Y+rNusXtaFq3EGGYifdlyzqk9klC3Z1TUO5mRrPZUkdfPGcZVQ1qWsBbVp
         aEVUHI6I/aTrrfo/MV7xyXEwF83JwpbRISFUz8nE=
Received: by mail-qk1-f171.google.com with SMTP id m2so1263248qkd.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 01:21:37 -0700 (PDT)
X-Gm-Message-State: APjAAAVSAbNfELMki1RaxhBVDKSblTUj+3NiZKqJs57uD7rRU5l87VQh
        f8ZBPW2VJ4oWrsLW96PYsQ8QvhNMu0WYvB+Iww==
X-Google-Smtp-Source: APXvYqx5ejCkY9fe72OcGmf94BoTFotctm8sKQHs0c+t28xBDY3kO+0s2f5YYDS6tXkOiP1dIpurVvrb/lgdOXWoFBE=
X-Received: by 2002:a37:682:: with SMTP id 124mr1535692qkg.393.1567671696239;
 Thu, 05 Sep 2019 01:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190904123032.23263-1-broonie@kernel.org>
In-Reply-To: <20190904123032.23263-1-broonie@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 5 Sep 2019 09:21:24 +0100
X-Gmail-Original-Message-ID: <CAL_JsqK8hn8aHa0e-QhT5=dMqCd0_HzNWMHM1YbEC_2z8n-tXg@mail.gmail.com>
Message-ID: <CAL_JsqK8hn8aHa0e-QhT5=dMqCd0_HzNWMHM1YbEC_2z8n-tXg@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Fix regulator_get_optional() misuse
To:     Mark Brown <broonie@kernel.org>,
        Steven Price <steven.price@arm.com>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Steven

On Wed, Sep 4, 2019 at 1:30 PM Mark Brown <broonie@kernel.org> wrote:
>
> The panfrost driver requests a supply using regulator_get_optional()
> but both the name of the supply and the usage pattern suggest that it is
> being used for the main power for the device and is not at all optional
> for the device for function, there is no meaningful handling for absent
> supplies.  Such regulators should use the vanilla regulator_get()
> interface, it will ensure that even if a supply is not described in the
> system integration one will be provided in software.

I guess commits e21dd290881b ("drm/panfrost: Enable devfreq to work
without regulator") and c90f30812a79 ("drm/panfrost: Add missing check
for pfdev->regulator")
in -next should be reverted or partially reverted?

Rob
