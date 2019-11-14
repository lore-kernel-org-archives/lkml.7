Return-Path: <SRS0=RWM+=ZG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58D3FC432C3
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2982E2070E
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Nov 2019 17:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="heWxqfCm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727031AbfKNRTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Nov 2019 12:19:23 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37813 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbfKNRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Nov 2019 12:19:22 -0500
Received: by mail-pl1-f196.google.com with SMTP id bb5so2913367plb.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2019 09:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:to:from:subject:user-agent:date;
        bh=VROg+K4TnY3eAbuPo8JrWf/C2byY5+4xNeCDIHGsCeg=;
        b=heWxqfCmZNzfTeb32+KsxAmK9QmT+BSvtUhbQQds6N/0EWs8x30JKwk7l7OeGKpP+k
         Rn6qNv/aPihZZWzCsHOPMyQlqKmLOcE78qR9y5B05Zj9xou0l6VhRE3DGx+wxhPPkfd2
         SpMVcrep/VY8e9SeRZ72CgKFH9R+1+lu4c3z8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:date;
        bh=VROg+K4TnY3eAbuPo8JrWf/C2byY5+4xNeCDIHGsCeg=;
        b=Q7ydtZetD7ytZy0YNEmyDgrXfGQVARJnMnHiyqR8xRlgAX5EOqA3kL+twv4Yze7+EH
         XmjKg/Z1Zr6uTmRxD/FTMV0fprBQchFfkUuKBAinX+L4Vt3hkEtx8uU0tf26P4jkSHZM
         bTZRGffY9mmyTf/KdoeRR0W/BJm7rOoPcSp3vMj4K2k8mksKaQ5ZXe7sNjsHZug669uJ
         yOZR3LJzJLMaN0Qopae/Az3cwAEkv1tVxPF8IhWmCwTQWxSsgHmEwuXJ3DU18OL6lbY2
         lQKUDiHzUU6ivrJuEgbThQJEDdLvuTLx6ETFN0PYarzkBD8NqaWRwZEJPblCKREyqcLg
         gonw==
X-Gm-Message-State: APjAAAWdo0ciRo/HnIemMsCb8rro0e8zNL2ZRTsfQ4pBUm+2nKU+uVEu
        9QtVjx5WsrAR/EAz+2ORnuMZOzx+a3g=
X-Google-Smtp-Source: APXvYqw7or5Ucfv1vVWnxkJ7A//hqXzGl+dzF4j9Z+0zPBFHLT+WmTtkRBWBQm90pp4DCyaFAV6vIg==
X-Received: by 2002:a17:902:6508:: with SMTP id b8mr10286509plk.69.1573751960472;
        Thu, 14 Nov 2019 09:19:20 -0800 (PST)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n12sm7356081pgb.32.2019.11.14.09.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2019 09:19:20 -0800 (PST)
Message-ID: <5dcd8c98.1c69fb81.4690b.49fe@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191114081430.25427-1-bgodavar@codeaurora.org>
References: <20191114081430.25427-1-bgodavar@codeaurora.org>
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        tientzu@chromium.org, seanpaul@chromium.org
To:     Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        johan.hedberg@gmail.com, marcel@holtmann.org
From:   Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Enable clocks required for BT SOC
User-Agent: alot/0.8.1
Date:   Thu, 14 Nov 2019 09:19:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Balakrishna Godavarthi (2019-11-14 00:14:30)
> @@ -1423,6 +1427,20 @@ static int qca_power_off(struct hci_dev *hdev)
>         return 0;
>  }
> =20
> +static int qca_power_on(struct qca_serdev *qcadev)
> +{
> +       int err;
> +
> +       if (qcadev->susclk) {

clk_prepare_enable() shouldn't return anything besides 0 when passed a
NULL pointer. Please drop this if condition in addition to the one on
the clk_disable_unprepare().

> +               err =3D clk_prepare_enable(qcadev->susclk);
> +               if (err)
> +                       return err;
> +       }
