Return-Path: <SRS0=0OOB=TB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B51C43219
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C9ED20835
	for <linux-kernel@archiver.kernel.org>; Wed,  1 May 2019 17:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MvYa7E2U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfEARHE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 May 2019 13:07:04 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45084 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfEARHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 May 2019 13:07:04 -0400
Received: by mail-ot1-f67.google.com with SMTP id a10so6485035otl.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 10:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g7qnNr6MRSnXOVYDlHOY9LAc6zjoMyDbcD9t1WnGzmw=;
        b=MvYa7E2UKVx8S8EMnlKM+cSXsa+G5bLnaTqA2iyBLxmVjoEn2PnWbAv0fQ3wEeKRfB
         v5ygLbWkyrtuu1yCwqFcfafqd0/OczmJtSVhy2beVZ7uQvdkkA8DrQMoMaYiBeLkDeTP
         GysstmUcOFXKCuc6Hht30amiW4XmNlaEehq5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g7qnNr6MRSnXOVYDlHOY9LAc6zjoMyDbcD9t1WnGzmw=;
        b=J/qKuN55jMqfia55+MKFFG5oHGxVlyFRs7EPUySZ8UkuKGle5GjkqdI+h6vKcgkXvH
         cI829jZIiZFglF5ZxQ/NefdxIZZuLTNfgXSTIe74NV+AHhKUbUZGaCGdj30Qkh1jLdGJ
         6BEJNf5VSrzJuYnPhe+clugjoLpoha+X3ZPSDT84x/YT9qP4avZfOCYZF6/6/JBN+jHM
         TlmHYhlzoZ61aaAKhuoXG3MLbKSidBXz0tWdjHwAURb+jtnZo0i66kjcIahZ1D0ob/vw
         kycXBY6zxGqHpsAqHrw0xw4H4qsmkjqL8nyL3pS0LQOu/2Y/26dDTPZKY9mD9x1QIgDe
         CY/g==
X-Gm-Message-State: APjAAAX2M3pe+ft7MyVBCT0UsZ8Hjd0fEEhNx5Tt4FKZS6Hq1oNEgc6V
        4HrGV81px2lxceQhim6AuA6K+ukso54=
X-Google-Smtp-Source: APXvYqyvlU9FsmOYB2kSqGndugUFByflaVDLs8wYd4Rp6AOESRvXAP7H6X7PSxddKVN9Hs1M1I+5Lw==
X-Received: by 2002:a9d:560e:: with SMTP id e14mr3321869oti.31.1556730423546;
        Wed, 01 May 2019 10:07:03 -0700 (PDT)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com. [209.85.167.172])
        by smtp.gmail.com with ESMTPSA id o1sm18137066otj.11.2019.05.01.10.07.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 May 2019 10:07:00 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id l203so14319484oia.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2019 10:07:00 -0700 (PDT)
X-Received: by 2002:aca:3e56:: with SMTP id l83mr6950442oia.111.1556730419948;
 Wed, 01 May 2019 10:06:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190417012048.87977-1-ncrews@chromium.org> <CAHX4x8483=65JVKRoZn9RadmoCp0VObLCH6BZO6dFT28B_r0ew@mail.gmail.com>
In-Reply-To: <CAHX4x8483=65JVKRoZn9RadmoCp0VObLCH6BZO6dFT28B_r0ew@mail.gmail.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Wed, 1 May 2019 11:06:48 -0600
X-Gmail-Original-Message-ID: <CAHX4x85QsjwnePOdmurJpifMpTMFO=YxFgnLsXPjWaswTgBa_A@mail.gmail.com>
Message-ID: <CAHX4x85QsjwnePOdmurJpifMpTMFO=YxFgnLsXPjWaswTgBa_A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] platform/chrome: wilco_ec: Add Boot on AC support
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Erat <derat@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Simon Glass <sjg@chromium.org>, bartfab@chromium.org,
        Oleh Lamzin <lamzin@google.com>,
        Jason Wong <jchwong@google.com>,
        Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Are these two patches an acceptable use of sysfs? There were concerns
earlier about abusing sysfs, but I think that these two uses follow
other sysfs use-cases well.

Thanks,
Nick
