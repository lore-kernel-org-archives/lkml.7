Return-Path: <SRS0=eZ3S=UF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2B8C04AB5
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:51:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5868E206BB
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Jun 2019 16:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="DaczKw26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfFFQvb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Jun 2019 12:51:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34170 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfFFQva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jun 2019 12:51:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id i2so1164080plt.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2019 09:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=aa8v2Ry0AgUyHqDSDkVaopTmArzSQkUiolk4pn2d3+s=;
        b=DaczKw269EV7LA54BQf75jZoNq5u89tfhtV1e6vBRU8zQDjavkM/B5+S8OlIYrhtBu
         zRH8KJfNZ6SVzujhafnICd+ZNaQPV4/8QuIo358hspBB/EagYVbB+x62egPUDT/JhNKv
         9e3V3l9q2a6BMyCyYGBeVLCvjHYdIr3XNvYQzsTbFciUxEEFGrpz5QhM2uEJlBQ5y4I1
         fPVGsCzLhzuSHn1Zj4OR7+kgIkt3FlwF/jdEnwlTk8YmlFaNX1Vtsk+Um1u8sd0cdumd
         b2KlyDEjmllwz6zSkUx/JA10Cfu3DmLno0xnQJLKue+RN9jjE86nky1JRkl7usEyBaZ8
         cEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=aa8v2Ry0AgUyHqDSDkVaopTmArzSQkUiolk4pn2d3+s=;
        b=fbVPaecZvY1fT+YB24zioeSXrDbL6nUusgRgn71xiDSpBVruZCoTPNNcHsL7Iczdjq
         mkoHoRgq+pYVR+q6okX6fX2XnAi2keHb6Bb3GMguOjCNjk1ay0XRATPTUJEWAnlfvqA9
         SZZWlsar+CRIQSU9MFnJhG7HU5+RIVflIhG2tUfBIzoa73pJqlMqJvOKofNpRlTez7qf
         09eHucjvm0JM9aDNriQXuLWNH+XKyk2/Ev9QndlMX+euEQA3ocyZRuitoDztrDqs/TTm
         gi0BGwKqkiSi7or8+vux+zqzPQAR9oUEK3LSiRbsF3qajx9D/t9svsUkOZ/9LwAW7KrY
         xeNQ==
X-Gm-Message-State: APjAAAU1hLV9lsZzu0lO5HrQCJbn5ip7Qak+/dpYVigS2GvOdpo/uZ87
        2tI9Yw2hNX1RCuedpwF1L4hUMXAvJt0=
X-Google-Smtp-Source: APXvYqwf3kWtPMwOnmP7ZZOYSimryM81jqIIaWq+An6NiWUG8IxZBgCpaGSayfH926J5f/CiXcB0PA==
X-Received: by 2002:a17:902:b18f:: with SMTP id s15mr52670524plr.44.1559839890184;
        Thu, 06 Jun 2019 09:51:30 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.googlemail.com with ESMTPSA id r77sm2336028pgr.93.2019.06.06.09.51.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 09:51:29 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>,
        dri-devel@lists.freedesktop.org
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] drm/meson: update with SPDX Licence identifier
In-Reply-To: <20190520142927.1009-1-narmstrong@baylibre.com>
References: <20190520142927.1009-1-narmstrong@baylibre.com>
Date:   Thu, 06 Jun 2019 09:51:27 -0700
Message-ID: <7hef46fyi8.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Armstrong <narmstrong@baylibre.com> writes:

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>

Reviewed-by: Kevin Hilman <khilman@baylibre.com>

