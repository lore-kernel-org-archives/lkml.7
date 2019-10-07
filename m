Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D82F8C47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFC4C206C2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 15:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QbjIAco5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfJGPbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 11:31:25 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45078 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728481AbfJGPbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 11:31:24 -0400
Received: by mail-pg1-f195.google.com with SMTP id q7so8399158pgi.12
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 08:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=sLa90r2E5qlyRjXK3gQlBRKqNd6GDxwpHpyhcXOfQ84=;
        b=QbjIAco5PbtWgtLkhrQ4/gHl6xagLiNSKZe2tmKrNuHEWeSuY3bQ3eBYHYkc41MgoL
         lE9Q4QKHjyNKwWLMkweolU9b3sx9Ydrk+blM0TNI7J39nNsjXmzwAVGp65LxInUJ4fwg
         YbzCdwCJasI2YsCnGLpatsKK/QpODrHB1wmdo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=sLa90r2E5qlyRjXK3gQlBRKqNd6GDxwpHpyhcXOfQ84=;
        b=uDuq1zAIkwTNHaNxsomtUyDjdFDMIXfiOpJicbv8lu/7Zfp6O9pmLZ398Qwuw/tHHV
         OGV9t3rwuX6OOs8sscaeCwgWYZ4lgI57dTasIn60Q1Mtq+e+znm8CkKJvkn9Mu3JbIe7
         OoFimwcbdmJ+to1WzagG7yaScFOLv42GRD7BAaLoNu73RbdYZhrUbeNKn8ojyV66Ggsx
         zwWB8vhTcGFCO1g7oPTIFTg38s1qsiGnRtZQEM5Gg/IbX+lja52pb4Yjm835rUw2GfVM
         ol5Ajmt0BjhqHktWRTQvimLx7v4OWNiIF9xMWlNvtmgxStOjjJ9KOvHphm8cJwZvqQXl
         VIfw==
X-Gm-Message-State: APjAAAVl1TJKWtzuekTVffYLxQGGUzxZDZsIHEc426LmEHM4yQhnthNk
        gsIdau8VWKp7lcMFmhUx4RrYc5JHkVM=
X-Google-Smtp-Source: APXvYqyIU0rNZmiZHnbdrXWq7p1j4lmE+m6tu39BGijoWH3TY0UhR+2MBJUz0zov8iXZjViNRKAozQ==
X-Received: by 2002:aa7:8d8a:: with SMTP id i10mr33512099pfr.45.1570462283513;
        Mon, 07 Oct 2019 08:31:23 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 62sm16190658pfg.164.2019.10.07.08.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2019 08:31:23 -0700 (PDT)
Message-ID: <5d9b5a4b.1c69fb81.d0598.1f8c@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191005210449.3926-3-hdegoede@redhat.com>
References: <20191005210449.3926-1-hdegoede@redhat.com> <20191005210449.3926-3-hdegoede@redhat.com>
From:   Stephen Boyd <swboyd@chromium.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] usb: dwc3: Switch to platform_get_irq_byname_optional()
User-Agent: alot/0.8.1
Date:   Mon, 07 Oct 2019 08:31:22 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Hans de Goede (2019-10-05 14:04:48)
> The dwc3 code to get the "peripheral" / "host" / "otg" IRQ first tries
> platform_get_irq_byname() and then falls back to the IRQ at index 0 if
> the platform_get_irq_byname().
>=20
> In this case we do not want platform_get_irq_byname() to print an error
> on failure, so switch to platform_get_irq_byname_optional() instead which
> does not print an error.
>=20
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=3D205037
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

