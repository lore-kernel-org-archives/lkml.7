Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B19A3C74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887C8208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 21:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ix9E8oHq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbfGJVMb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 17:12:31 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43719 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbfGJVM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 17:12:29 -0400
Received: by mail-lf1-f67.google.com with SMTP id c19so2567977lfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 14:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwvajVWMIb62q8wACGYhWs29kEXd/GDO5w+T3eFYJVQ=;
        b=ix9E8oHqVOHHI7+NbnlUqfsJnN4HBLwyr0Jn9m3Tpk6LEOunHnYze3vGWP8/aAN+JQ
         o8Xb6a4lS1X88VxaIJw7qDyL2rtrdl8yPiVKxFJVDlBDzUn/5GBcvnogmRiipUUSaZ2A
         y62oVYOH++N07WuupIrdvk0x7owfObLe29Q5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwvajVWMIb62q8wACGYhWs29kEXd/GDO5w+T3eFYJVQ=;
        b=ldm1B6cw/+bwDI05EnqLwG1qyfyUaCXyJP1+sbt7BM0ut7/rEYC5FQ/jdLuY3kNgoO
         vuXX3ItHwDivN1FhQfgWSUy4Xl5vz9A+ZFCGYy/ujsLcmef36Gw3m5Z2lqmXjpmuhDAw
         Zcw1m7eVKlPQjtRqsqv9s03LftD3mP9+JlVfO/qsw+V8KpjZx/EWm6j3skjUIm8Esk/k
         CY7AhWBcjUDg9DCZQnxCFU9TPoW0Ruv2nB0i3lpNI/jqpGR2Qnj57LFgzEjZesqsAKj3
         fQrEPVwLip3nMkLtqvNWZqclAZRrKknHSj+PtcCU+al5TPqbqF9yq1WNOzDarzWa19yU
         y9pg==
X-Gm-Message-State: APjAAAU37sKg+rUIgHKD8NFch5GtA5A9xVUTYCk0bEaFgKbo9S0ETp75
        IIg20DfMG67vHdyW9Z1IWZp0JKbprU4=
X-Google-Smtp-Source: APXvYqxzEBJOt8ueGEubSTF+fou+Cn2eOm0sKw16dXnqExFQQyJtM2IemWzq5zK9NRfIXbx0w3Khaw==
X-Received: by 2002:a05:6512:c1:: with SMTP id c1mr16944792lfp.35.1562793147001;
        Wed, 10 Jul 2019 14:12:27 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id i62sm640052lji.14.2019.07.10.14.12.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 14:12:26 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id r15so2548358lfm.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 14:12:25 -0700 (PDT)
X-Received: by 2002:a19:6519:: with SMTP id z25mr6190697lfb.42.1562793144979;
 Wed, 10 Jul 2019 14:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190627003616.20767-1-sashal@kernel.org> <20190627003616.20767-14-sashal@kernel.org>
 <CA+ASDXPyGECiq9gZmFj8TU6Gmt2epQtuBqnGqRWad79DJT589w@mail.gmail.com> <20190710145112.GX10104@sasha-vm>
In-Reply-To: <20190710145112.GX10104@sasha-vm>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 10 Jul 2019 14:12:12 -0700
X-Gmail-Original-Message-ID: <CA+ASDXPseNZkud1vu9zaRH-vA0rJq8D_t6pFG1LTPQtdr8_eVA@mail.gmail.com>
Message-ID: <CA+ASDXPseNZkud1vu9zaRH-vA0rJq8D_t6pFG1LTPQtdr8_eVA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 4.19 14/60] mwifiex: Abort at too short BSS
 descriptor element
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        "<netdev@vger.kernel.org>" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 7:51 AM Sasha Levin <sashal@kernel.org> wrote:
> I see that 63d7ef36103d didn't make it into 5.2, so I'll just drop this
> for now.

Yeah, I think it's stuck at net/master. Presumably it'll get into
5.3-rc somewhere.

Brian
