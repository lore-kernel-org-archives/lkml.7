Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10A9C32792
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95D8D2168B
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 22:26:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FEXFmDSW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730607AbfI3W0P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 18:26:15 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38950 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbfI3W0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 18:26:15 -0400
Received: by mail-pl1-f196.google.com with SMTP id s17so4443971plp.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 15:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:from:to:cc:subject:user-agent:date;
        bh=gNsbryt7zNBbao6S6XuAFO6RWtb7mB6GkwvJUITq7vM=;
        b=FEXFmDSWmj9zN3ls+08cfHJNs9Lsa2F0tEzABAFOuqGbjQROJS6TNJU5LLLV8Qf6Yw
         +kkcd6TuvfCWfghRPjvVmC458yCnJNKvq1bpGzjnfNSIZnaZ1Xc62B67lrYXSeW2vUp0
         ZKyOdm+DwVGgaOV2BTZyedDwuc/YgjOZprM94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:from:to:cc:subject
         :user-agent:date;
        bh=gNsbryt7zNBbao6S6XuAFO6RWtb7mB6GkwvJUITq7vM=;
        b=Rw/T1OjJ8AXBj9Snplpul0gGjQi7gtBC2lIlOEVP8seYyrSAbOiP6Eo31SMAxl3HQd
         KaaixLPYyF7WhN/Likqo5gZIiM6K4NPK4Xn6xpacqcX5Gjvqc9jPZxkh1VLjKjcSYH92
         jXoVkvBGs/yd889SzLfEouuY9Ye6ClY2o+BtEnJMsqu3vr0pMLj9YHWJITCxhwnFKh65
         agd/QipPCXdFTPp847CHSZn24XpUMHsrPo1vnncENqjXfZniqIXMclyY99n1mFoUZKkK
         Or8VIFeGikDz6KITNot+NRzAWsirGXRopd4lrUz1k6RkIZ4nY9wEi96CAk7rV3oHQubp
         orZA==
X-Gm-Message-State: APjAAAVOigWq/ZVlC02uwJglo4EPmQcr4bXescgZOlm2DYjVqa+THhVU
        K8JGDHN8GBz+WqY1P1vw51ZDKA==
X-Google-Smtp-Source: APXvYqyvW7KnD4p6RRzMyQjVNhtlhTTZF+raYHO8fe9TpmKW4CBZvkZUT8KHrNro7nlOT/UpLtas9g==
X-Received: by 2002:a17:902:aa04:: with SMTP id be4mr14295817plb.40.1569882373177;
        Mon, 30 Sep 2019 15:26:13 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l37sm8474089pgb.11.2019.09.30.15.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2019 15:26:12 -0700 (PDT)
Message-ID: <5d928104.1c69fb81.29df9.6eef@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190930214522.240680-1-briannorris@chromium.org>
References: <20190930214522.240680-1-briannorris@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
To:     Brian Norris <briannorris@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Hung-Te Lin <hungte@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        stable@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] firmware: google: increment VPD key_len properly
User-Agent: alot/0.8.1
Date:   Mon, 30 Sep 2019 15:26:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Norris (2019-09-30 14:45:22)
> Commit 4b708b7b1a2c ("firmware: google: check if size is valid when
> decoding VPD data") adds length checks, but the new vpd_decode_entry()
> function botched the logic -- it adds the key length twice, instead of
> adding the key and value lengths separately.
>=20
> On my local system, this means vpd.c's vpd_section_create_attribs() hits
> an error case after the first attribute it parses, since it's no longer
> looking at the correct offset. With this patch, I'm back to seeing all
> the correct attributes in /sys/firmware/vpd/...
>=20
> Fixes: 4b708b7b1a2c ("firmware: google: check if size is valid when decod=
ing VPD data")
> Cc: <stable@vger.kernel.org>
> Cc: Hung-Te Lin <hungte@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

