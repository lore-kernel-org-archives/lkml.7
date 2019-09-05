Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B889C41514
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2542173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="f2rMlOI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731686AbfIEG4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 02:56:20 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:36755 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730737AbfIEG4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:56:20 -0400
Received: by mail-pl1-f173.google.com with SMTP id f19so827743plr.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Sep 2019 23:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=message-id:mime-version:content-transfer-encoding:in-reply-to
         :references:cc:subject:to:from:user-agent:date;
        bh=kD97/EVwUs7hGEhtRI5cM+0lTbQL7Vks32M4YRn4nes=;
        b=f2rMlOI6tTwlUpDkj66CovnKcTx6AuUUeHc9hOI4VWUSXRKLIxz27UOd5KOENqMiQ7
         dybXYDbJwAIufmq7n1UxvQm/WEPpxLLjaALsxCUkxrnO5W7hamAYRggydmoIH7VoWr3J
         VB93qsszzkcRQ3gnS/rpS3YzCzK8JnFEqgGEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:in-reply-to:references:cc:subject:to:from
         :user-agent:date;
        bh=kD97/EVwUs7hGEhtRI5cM+0lTbQL7Vks32M4YRn4nes=;
        b=rMaTtKVw4nF5nENmyQZ/7FDLBtQ0dAPE4/7In6ewhOBED5LtcMqCXv0CgK/f7xVHuY
         djgkUKmYwpoHnB6tXvf89tZ/BR1oOR9MjjyL9NikqwroRJlw7k/IJ0TZxKjgagFfaCjM
         abaDtMLbC5UoY2pwUX/thCONLOhWy2tOh6OnnoS3uS0DtSijXaSZFTvGorq7CdA9YtL/
         vJYcOl9woU4eyE7KoG0z7MxtmeFjoN9gjG1qAImkSS7DsAgMsqIZoe4EnimWgzr8Onq5
         j+MB1/6pY/nlbvpzQpilbpCZ+TNGPgaZ//hCUqvYQrpvmxfHec7kn+5o19SIw+tyQIKY
         QnRg==
X-Gm-Message-State: APjAAAWlK/ggvlNdUZm2dQoNSZRqPmYW9tg2D1v8yt8w/ezjp3h7Lnk7
        NZ2BUogDs7uVb0+l6bhJv4QJtg==
X-Google-Smtp-Source: APXvYqzKn1EYDsMpOUWI7sFFZU4cXOjhZbtxWRrgczbEbqf4U+wCl33fGmcpyZGHJD9ZjijclNyYsw==
X-Received: by 2002:a17:902:820a:: with SMTP id x10mr1817462pln.216.1567666579544;
        Wed, 04 Sep 2019 23:56:19 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id n9sm1030819pjq.30.2019.09.04.23.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2019 23:56:19 -0700 (PDT)
Message-ID: <5d70b193.1c69fb81.f9ce7.3447@mx.google.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190905064253.GU26880@dell>
References: <20190903135052.13827-1-lee.jones@linaro.org> <20190904031922.GC574@tuxbook-pro> <20190904084554.GF26880@dell> <20190904182732.GE574@tuxbook-pro> <5d704c9f.1c69fb81.a1686.0eb3@mx.google.com> <20190905064253.GU26880@dell>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, agross@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/1] soc: qcom: geni: Provide parameter error checking
To:     Lee Jones <lee.jones@linaro.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.8.1
Date:   Wed, 04 Sep 2019 23:56:17 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lee Jones (2019-09-04 23:42:53)
> > > But if this is the one whack left to get the thing to boot then I thi=
nk
> > > we should merge it.
> >=20
> > Agreed.
>=20
> Thanks Stephen.
>=20
> Unless you guys scream loudly, I'm going to convert these to Acks.
>=20
> If you scream softly, I can convert the to Reviewed-bys.
>=20

<in a soft scream>

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

