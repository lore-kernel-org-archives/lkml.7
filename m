Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F920C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BE1E22BF5
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="D5N9xFES"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbfGYNZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:25:14 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52173 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727320AbfGYNZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:25:13 -0400
Received: by mail-wm1-f65.google.com with SMTP id 207so45007992wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=6aDJ94uyyhxgWSyExse9QYlquEyyOJ9JE7SxUePnMhA=;
        b=D5N9xFESPh6uCOxGlZuTzAA4mb7oWHRhDyTjlYtFlwi6bJdhcbNT5E59VtjKhctWnn
         WdkJDf7qZM6dH8RhDOONw43oJBVvhk44/kZjXkF71AncceV6SsngmzIu48GsS/b2XqQo
         l6JJY+duWSKVwsmsptTyrXnzjpENPoQ2DL8Q3TcuNpihHyUaeSlxw+onu3zGEpFbnT91
         hHoJO8pSkk7svMhzZo2foJg5rEyD2QvGIQJTsJJXuAkUenK4O9J3vG1S7kxcH7aX10j8
         FPkQCcXcehBkj79s3Upnry4gyUmatXOHp1WPmbIHRGmmXDWYeBwwQWKnqvK30Z9kbiR3
         eQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6aDJ94uyyhxgWSyExse9QYlquEyyOJ9JE7SxUePnMhA=;
        b=BKv/Fx/9UQetXox4u63cZUauPIPqfJkYCXSaIH2OGGASmkXWodT59h49YjRmgsgNcD
         jLQGItRSL5e5lUZHSEf6G9wcWbXPMAwUnFv8JcH8l0J4hda323gDF4aIo6DT6xYxS9Hk
         DtW0SBZJnrmfrHW+8GcIz/B3LJoIOB+P+NwIRI/G0uJyYpxDTCeIGcWOxGLAKimhlypY
         K6IHchdNKwhQyq0L9GqL+ee9HkOw88Gz7ddGD/wcXT1/bIG7tSi3jL5iZT0NkQAMqSQ2
         3UjCEhxq83CrZPs/tTjXhTEdpEZadyoHVEMNiDeTvcVL8mqXyX9JQWsyEFAigcS7NPLm
         vo6Q==
X-Gm-Message-State: APjAAAXhn0m9af7lpy00JP4RArlUNTwJmYofdjIGLTluIr5QZZzUYhhy
        34uaSjhLEvCgMMGjOp5LwLz0Ag==
X-Google-Smtp-Source: APXvYqzkB7UJ5b3t6lNCXexFXjlZMe0BgyF3qfh59IwBeXFA97QLF/U3xl/ncqsPvbVWUg8lQVWfpA==
X-Received: by 2002:a7b:c8c3:: with SMTP id f3mr15113128wml.124.1564061111601;
        Thu, 25 Jul 2019 06:25:11 -0700 (PDT)
Received: from localhost (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id h1sm35852177wrt.20.2019.07.25.06.25.10
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 06:25:11 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 3/6] ASoC: codec2codec: deal with params when necessary
In-Reply-To: <20190725125534.GB4213@sirena.org.uk>
References: <20190724162405.6574-1-jbrunet@baylibre.com> <20190724162405.6574-4-jbrunet@baylibre.com> <20190725125534.GB4213@sirena.org.uk>
Date:   Thu, 25 Jul 2019 15:25:10 +0200
Message-ID: <1jimrqxn49.fsf@starbuckisacylon.baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25 Jul 2019 at 13:55, Mark Brown <broonie@kernel.org> wrote:

> On Wed, Jul 24, 2019 at 06:24:02PM +0200, Jerome Brunet wrote:
>
>> Also, params does not need to be dynamically allocated as it does not
>> need to survive the event.
>
> It's dynamically allocated because it's a pretty large structure and so
> the limited stack sizes the kernel has make it a bit uncomfortable to
> put it on the stack.

Ok, I'll revert this in v2
