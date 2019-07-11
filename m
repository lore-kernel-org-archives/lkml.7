Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A502C74A41
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 00:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D233821530
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 00:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nPIq4MYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfGKAkp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 20:40:45 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41121 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfGKAko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 20:40:44 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so4078644ota.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 17:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRxHbQJUv2T55q/06mFxT6UHW4SoaZqc6/AtO2q+TCk=;
        b=nPIq4MYp1Jeuw8NeIRF96fBnbfWao+w3VanqHjwh6HMYJS1Ox5s6oZAQmLxPyDBB+f
         /tSbtuIBkpHACNM/zJONQqWHcQiZ7zyY47znCEghmf8w6VNXiCGGR++xrvzsu7ZfiKPA
         zDkps+El/aiJmWvi/1Gc0IHA8cC2osoN/shYv/dhYw2/m5TYiQvj++Bh4BOjxdK10S8E
         31z6ksbfHJLoMm+eGqIu0CM0skJ96UPr6vNf8kVPJ2koH63vxPewBCZzlWETXYc9Lz6g
         4F+Lg5P+z8Nvm36GLQJAQ7V59qiecO417qwhOGNGL8N9K1buGOFSMooYC9mpIs4Bfkmp
         cRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRxHbQJUv2T55q/06mFxT6UHW4SoaZqc6/AtO2q+TCk=;
        b=SJvUppCqMXs8e62B0K6MlUlzhUeKGpOqRCcd9uW5SKbASFagrbUwhFfOghD7AWkSqP
         DcQ2RSjWFfjW/k6SW2mMzjkLUj1B/qUFyDjXhVXcI1KEd7QyDqAVNmCoLh0qhFhEkb50
         SHBcSFCs+LJ4pK+lcbqbE5fzXLk0szxk9ZQlTWGimo2d/VKw5eXb3HavIuVItLfhz968
         jCVHud7th/XpOQL3i14Ct/oRlVL8z/JNHD6LGz9ON88hJbb/csxMIMq9IL7CWjquwDXo
         f7bIt/goxp4hXo6T7qy2POrIiEXuHZnUyyuf5IY9ZavwO5K0xw16mJBJLhqyTbFR8Jkk
         zVyg==
X-Gm-Message-State: APjAAAVhaW2I/eT6q0lF2rs2tYny6W/NO/eWV+7Hk43cSOlV3VJ5nFDm
        WI+I3cPOcRcsUk7iNvZnGupp2pEjuK4I+hCyiqZHnw==
X-Google-Smtp-Source: APXvYqxvyXf3j4ah2asatdlAdmPmxamClfiBWHPA0zmtMfnmPxGneAZKDvFGXKZ1Zh65bAQxTxz4A1zOC1eHrX/DxsE=
X-Received: by 2002:a05:6830:2010:: with SMTP id e16mr982366otp.344.1562805643578;
 Wed, 10 Jul 2019 17:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190711021344.774c81e2@canb.auug.org.au>
In-Reply-To: <20190711021344.774c81e2@canb.auug.org.au>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 11 Jul 2019 08:40:32 +0800
Message-ID: <CA+Px+wUFhqAP6G+5uaECc2dArVC6-ZUD6FUEL3D9WQ7-FMmzbg@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the sound-asoc tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 11, 2019 at 12:13 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> In commit
>
>   6cd249cfad68 ("ASoC: max98357a: use mdelay for sdmode-delay")
>
> Fixes tag
>
>   Fixes: cec5b01f8f1c ("ASoC: max98357a: avoid speaker pop when playback
>
> has these problem(s):
>
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
>
> Please do not split Fixes tags over more than one line. Also, don't
> include blank lines among the tags.
I am sorry for this fault.

Mark, do you need me to resend the patch to fix the commit message?
