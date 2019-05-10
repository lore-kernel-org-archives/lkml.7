Return-Path: <SRS0=sufd=TK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC05C04A6B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F76820850
	for <linux-kernel@archiver.kernel.org>; Fri, 10 May 2019 08:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="iELlAWp8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbfEJIhE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 May 2019 04:37:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38453 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfEJIhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 May 2019 04:37:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id d13so5676081qth.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2019 01:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6q0OaTNhxy4z4NJtiUVwPY8QmQQzdj/ZZVApy0GJMI4=;
        b=iELlAWp8uu1w9QKiqsaCDDQUQZVz8W7Axyi1mnxbi0BiAfs+E4txY0WxHylQWI7/Ie
         kEl6z5C/Emaw0fQRI6D7NkEJhoFhEmattbkSrZj6CnA4samxPOlYRqcjwt0uyWUpXOwt
         MSCK8uPjMuzMjgx7xg4cIRI4vmsDnrucQVGgHCeFPGyUkUxqw6aAeChk/AFFHS7mw7F6
         sMMJz+grUiuBh91XLPH5oEAuTVGufIx5c7IRSYlZnveFOb3HVEKgbP8rPku1Ktqebwmb
         zU7I/kHcwWHm8kcSyzf8eHN2KGexnO6N3bBc3Xy9+xssu+OtLg6gop+0xBAWBoQ4Bd5m
         BsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6q0OaTNhxy4z4NJtiUVwPY8QmQQzdj/ZZVApy0GJMI4=;
        b=PMzQTQS+QoflGeL0Fr1+NWqqnFBWenhHW1jN81h5PgpLCH4jfWpwONag/t81c09TxA
         Gnob6rNuZEFnhCqXl6THdM6EeTn8FylsZCAGssNlVYKIU42Tu1UIgByCafm93vW0KMJU
         WcBPcX1wS+v56LrPdnjH5mWwjN6S9Pd76vPrUYQL1WXfeoB5DFnAEgcDbW+bI3kkmqx0
         BlPaO6rHOKG9IJhR4sRVUULolsSyjI2miB2hPacUS+fwoRb0eJYni9z+++REB7n/YvB8
         EdUNR7z9GVjN6j/7zGBsUHEnXo4sDvYPbX4+n6DtsHtWO1pBo8dZbrsTHCxJhhhECJtu
         Dvbw==
X-Gm-Message-State: APjAAAVffdjKQ7VJJ5T/AKoxJFsqhFZEp/XY8HkHJvafG+j1EUVuEl8L
        eSXl0YXW4u46/23J/IF/x9Zl4FgwZZ6zDhS7eIV/KQ==
X-Google-Smtp-Source: APXvYqw4qHdkcVnmbbairiiIOuet0C5L8KHTlEuaG0iO/gCejSKaySvSBAsfB9wxI2MBrau5nbVgefJaBuBg8UnoKPA=
X-Received: by 2002:a0c:8a93:: with SMTP id 19mr820888qvv.7.1557477423165;
 Fri, 10 May 2019 01:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190503072146.49999-1-chiu@endlessm.com> <20190503072146.49999-3-chiu@endlessm.com>
 <CAD8Lp47_-6d2wCAs5QbuR6Mw2w91TyJ9W3kFiJHH4F_6dXqnHg@mail.gmail.com>
 <CAB4CAweQXz=wQGA5t7BwWYdwbRrHCji+BWc0G52SUcZFGc8Pnw@mail.gmail.com> <CAD8Lp46hcx0ZHFMUdXdR6unbeMQJsfyuEQ7hUFpHY2jU9R7Gcw@mail.gmail.com>
In-Reply-To: <CAD8Lp46hcx0ZHFMUdXdR6unbeMQJsfyuEQ7hUFpHY2jU9R7Gcw@mail.gmail.com>
From:   Chris Chiu <chiu@endlessm.com>
Date:   Fri, 10 May 2019 16:36:51 +0800
Message-ID: <CAB4CAwf26pdCY7FJA5H7d1aEY2xpjSto4JxARwczmVJ==41yng@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] rtl8xxxu: Add watchdog to update rate mask by
 signal strength
To:     Daniel Drake <drake@endlessm.com>
Cc:     Jes Sorensen <jes.sorensen@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 9, 2019 at 7:24 PM Daniel Drake <drake@endlessm.com> wrote:
>
> On Thu, May 9, 2019 at 5:17 PM Chris Chiu <chiu@endlessm.com> wrote:
> > I need the vif because there's seems no easy way to get RSSI. Please
> > suggest if there's any better idea for this. I believe multiple vifs is for AP
> > mode (with more than 1 virtual AP/SSIDs) and the Station+AP coexist
> > mode. But the rtl8xxxu driver basically supports only Station mode.
>
> Yes, the driver only lets you create station interfaces, but it lets
> you create several of them.
> I'm not sure if that is intentional (and meaningful), or if its a bug.
> Maybe you can experiment with multiple station interfaces and see if
> it works in a meaningful way?
>
> Daniel

I've verified that multiple virtual interface can not work simultaneously in
STA mode. I assigned different mac address for different vifs, I can only
bring only one interface up. If I want to bring the second vif up, it always
complains "SIOCSIFFLAGS: Device or resource busy". But I'm sure that
STA vif can coexist with monitor mode vif. So I may need to add the code
login to make the watchdog only work with the vif in STA mode. Then I
can also store vif in the rtl8xxxu_priv structure if we presume it only works
for station mode. Anyone can suggest whether if this assumption is correct
or not?

Chris
