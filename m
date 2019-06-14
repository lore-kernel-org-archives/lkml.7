Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAFAAC31E50
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 22:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C2D2183F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 22:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=comcastmailservice.net header.i=@comcastmailservice.net header.b="daqajcve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbfFNWTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 18:19:03 -0400
Received: from resqmta-ch2-06v.sys.comcast.net ([69.252.207.38]:49854 "EHLO
        resqmta-ch2-06v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725812AbfFNWTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 18:19:03 -0400
X-Greylist: delayed 488 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Jun 2019 18:19:02 EDT
Received: from resomta-ch2-04v.sys.comcast.net ([69.252.207.100])
        by resqmta-ch2-06v.sys.comcast.net with ESMTP
        id bthIhAKBheEFQbuPOhZFVc; Fri, 14 Jun 2019 22:10:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=comcastmailservice.net; s=20180828_2048; t=1560550254;
        bh=By1+KwAQDvxknCnYhgfG8EQ2r/nPs2JRxqJbokVnKho=;
        h=Received:Received:From:Subject:Reply-To:To:Message-ID:Date:
         MIME-Version:Content-Type;
        b=daqajcveYAWSO8iQLRTPCUxE2tADXUgb5w9Mzld8YZQfbdqF6KL5W8HIjqELMMFRC
         JqY1FcA4DtLTGRjqiq8h21+mpCUGYgNmM/vfju8hXnom76n52U1ePyVAdMoqUIVTpl
         DNu8QY4QG+VAyc8OOzU3CcB/en7ZMabb77j/6eP22kC1fhffmxgGqV9DWkoZapOXo0
         xFHv6Xv7OaS6nTElzsnBHjYsX9vZYageN0sH+b6en9s+0XzEVKdo2CcKAL7EaFwHPn
         lIIyKhwfUYmXq0PzHOpb6cOwjyBp+uEYWzmC5f0DasFwIFQ+zkF46RSXUhbJSHryWq
         gSPnsmxTWUr+Q==
Received: from [IPv6:2001:558:6040:22:2171:426f:b27e:296d] ([IPv6:2001:558:6040:22:2171:426f:b27e:296d])
        by resomta-ch2-04v.sys.comcast.net with ESMTPSA
        id buPMhbDdCXrm0buPNhURJ8; Fri, 14 Jun 2019 22:10:53 +0000
X-Xfinity-VMeta: sc=-100;st=legit
From:   James Feeney <james@nurealm.net>
Subject: Re: [PATCH 1/2] HID: input: make sure the wheel high resolution
 multiplier is set
Reply-To: james@nurealm.net
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Peter Hutterer <peter.hutterer@who-t.net>,
        Sasha Levin <sashal@kernel.org>, Jiri Kosina <jikos@kernel.org>
References: <20190423154615.18257-1-benjamin.tissoires@redhat.com>
 <CAO-hwJLCL95pAzO9kco2jo2_uCV2=3f5OEf=P=AoB9EpEjFTAw@mail.gmail.com>
 <43a56e9b-6e44-76b7-efff-fa8996183fbc@nurealm.net>
 <CAO-hwJK614pzseUsGqH65fCnrm=N7970i4_mqi0m1gdkY=J0ag@mail.gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Message-ID: <b6410e5d-b165-7a9b-2ef5-eb44c8de7753@nurealm.net>
Date:   Fri, 14 Jun 2019 16:09:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAO-hwJK614pzseUsGqH65fCnrm=N7970i4_mqi0m1gdkY=J0ag@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Everyone

On 4/24/19 10:41 AM, Benjamin Tissoires wrote:
>>> For a patch to be picked up by stable, it first needs to go in Linus'
>>> tree. Currently we are working on 5.1, so any stable patches need to
>>> go in 5.1 first. Then, once they hit Linus' tree, the stable team will
>>> pick them and backport them in the appropriate stable tree.

Hmm - so, I just booted linux 5.1.9, and this patch set is *still* missing from the kernel.

Is there anything that we can do about this?

James
