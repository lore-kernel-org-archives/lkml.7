Return-Path: <SRS0=KmSF=VS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2651DC76188
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:25:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E06B62085A
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jul 2019 10:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=out.zamailgate.com header.i=@out.zamailgate.com header.b="MczgHWsx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitlabs.co.za header.i=@bitlabs.co.za header.b="pQVZsPat"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfGUKZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jul 2019 06:25:35 -0400
Received: from za-outgoing-1-5.antispam.co.za ([164.160.88.55]:45925 "EHLO
        za-outgoing-1-5.antispam.co.za" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726020AbfGUKZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jul 2019 06:25:34 -0400
X-Greylist: delayed 1289 seconds by postgrey-1.27 at vger.kernel.org; Sun, 21 Jul 2019 06:25:31 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=out.zamailgate.com; s=default; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:reply-to:sender:bcc:
        content-transfer-encoding; bh=cfN2qzAmlFpQy+0KqMa3Rn6bw82Lej1+39POXqN23xw=;
         b=MczgHWsxlN6TJASQmkIF8Rm7fWo7u02RWhLiSeySkl1X8bz3XKhZ18yW9n8RF2uVgu/vNjj3eg
        brq6fMZTjRWN+YC3MWt08OMzgICr2MXh4lV30gW5P4htVUNDqUXjT3RPiD63SYnw8cMhtyuHq/z7Q
        WUut0E4m1+NBqyyGNVjU=;
Received: from cp46-jhb.za-dns.com ([164.160.91.39])
        by server1.antispam.co.za with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <hm@bitlabs.co.za>)
        id 1hp8h6-0008VG-S4; Sun, 21 Jul 2019 12:03:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=bitlabs.co.za; s=default; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=cfN2qzAmlFpQy+0KqMa3Rn6bw82Lej1+39POXqN23xw=; b=pQVZsPat3KmlHlrPOT8rGD7p4
        jQGqhNiW92ecCdjtMkPlDufl3KZMf/npfSdDQLyTKFaXwjUDc/LjdJLMy6pZbiz8X/xT0vo9AHxbs
        9vjJe1XHSePb/xgqbcHg1++F4yg1SU7mgB79FAfN3W7TAnjPxFQh1TPfe7/nP7fAXebZUiLKJyT0I
        Df/tFRm/2VG87xj7nPftGfFNcQqipc8qtD+CEXvg9buUrqW43hwRLvDG6tlff+rxrhy7VAHl2/fv5
        FdXQHklnCk4dsBk8y79BSsaHLRugoiv2ouMPazSBdWMeQQG5z+tFuXJzmYdMXRxtdTB7CiWYoWGy7
        yFBOQouHA==;
Received: from [45.56.148.82] (port=60140 helo=manjaro-1)
        by cp46-jhb.za-dns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <hm@bitlabs.co.za>)
        id 1hp8h1-0001gt-Sc; Sun, 21 Jul 2019 12:03:49 +0200
Date:   Sun, 21 Jul 2019 12:03:40 +0200
From:   Hennie Muller <hm@bitlabs.co.za>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tim Collier <osdevtc@gmail.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging/wlan-ng: Fixing "line over 80 characters"
 warnings.
Message-ID: <20190721100340.fa4hmnj5mszlcppz@manjaro-1>
References: <20190721091326.7363-1-hm@bitlabs.co.za>
 <20190721092919.GA9188@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190721092919.GA9188@kroah.com>
X-Get-Message-Sender-Via: cp46-jhb.za-dns.com: authenticated_id: hm@bitlabs.co.za
X-Authenticated-Sender: cp46-jhb.za-dns.com: hm@bitlabs.co.za
X-AuthUser: hm@bitlabs.co.za
X-AuthUsername: 
X-AuthDomain: @
X-Originating-IP: 164.160.91.39
X-SpamExperts-Domain: out.zamailgate.com
X-SpamExperts-Username: 164.160.91.39
Authentication-Results: antispam.co.za; auth=pass smtp.auth=164.160.91.39@out.zamailgate.com
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.01)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0STiPCilqAig5bem4hJMKBmpSDasLI4SayDByyq9LIhVza8ebghxj51x
 Dqp4JI4jIkTNWdUk1Ol2OGx3IfrIJKyP9eGNFz9TW9u+Jt8z2T3KTZMqjZ9tAWmqmNc2NgR7k+vh
 S+tbh18jTMao+YsbFonRbRLxY6iR/iP1vJ8wCVdpcmiTw2fyNIseT1DVvKHXE4WuHjpr5K811Lf0
 BmpxDPYq3bEypb4z2qpYxnFMeQdJU2Itm39BdCc4FEP6OrUewnSRpz3j4wp5y6IcCenJwdJ1hOKw
 D9qWCBVSlZZkX56uhzVOfKJsUZNl7t99vC1OXnORWtMjT53kfxS+JvuWMSriglwU9ohqNhNM9945
 3sfdd1z7gRMWz8FJukTOlUyTgn8BsZb5zYHlscjT7sj13Z3aUnOFsLmxiteAg/Lg3QQf9KF0/TSf
 HOH+bfnK0v9ZiKHuIBQAIL3H1ZJjKsJ4pLk2R4umujHCn/a9ItZXn4Sniqa/NuUbE2+6HbRht3k8
 HYUYyGHZUchh8KOtAnUBNk1FXXqpVcVFhDpgnnGd9TvwpduFUH54xozIXYC/AO4ruX5iUvr5iRfH
 YXcRLRD1STphX771MZaqO0tasMzsprIMwn4tuDmQ1yCNRDQnsmRAUWW2XuA1Eg+8Q0FElU4j8pn6
 91Swor8Z5o5Zc7JHts6r++DuIQUs/5JJj4C/n4CILrLNpjvo1yAmW11ULOBCGzlrDbpv6M5LGSJn
 Q2XsyaKqX4TmERdOMHDegLF8P6W3O7PxF/AwYIosKwfHBmgNmIZc2R7Q9NKpAO4gvXasHDoMLwu/
 kv5JvWHYA/isw5/l8REVniihuDwEGDcmr6e3OPRmKMUf4pRn4ggKuOyzs6WLeft3wBsu/+xyxy5+
 3L2RmHH0sBGzvAX+Ote8b0Oy2BpmPTcXEcWxx9Ays3pJvTunHro5DQ2iNQWS+MZYXqhS1hXQIZ2Q
 Z9pMw6t4RjTR03PDqcigOvSxdRnthmhn8Zn68dkJpo+VUTg3/FqJF2kJKpxThV2Kky5xlHYSMHwp
 QR9PpCxTVmIcakdpIUM1tmncd1z7gRMWz8FJukTOlUyTgkUyTHPQex6kpQP37eNlghnXaMSDkHw7
 +yU745pPrDwR6W+K0yVlrwnEUBgs9kmZlQ==
X-Report-Abuse-To: spam@server1.antispam.co.za
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 21, 2019 at 11:29:19AM +0200, Greg Kroah-Hartman wrote:
> On Sun, Jul 21, 2019 at 11:13:26AM +0200, Hennie Muller wrote:
> > Reindent multiline function calls to be tab aligned, instead of open brace
> > aligned. This fixes multiple "WARNING: line over 80 characters" generated
> > by checkpatch.
> > 
> > Signed-off-by: Hennie Muller <hm@bitlabs.co.za>
> > ---
> >  drivers/staging/wlan-ng/cfg80211.c    |  55 ++---
> >  drivers/staging/wlan-ng/hfa384x_usb.c | 282 +++++++++++++-------------
> >  drivers/staging/wlan-ng/p80211conv.c  |  48 +++--
> >  drivers/staging/wlan-ng/p80211req.c   |   6 +-
> >  drivers/staging/wlan-ng/prism2fw.c    | 101 +++++----
> >  drivers/staging/wlan-ng/prism2mgmt.c  | 170 ++++++++--------
> >  drivers/staging/wlan-ng/prism2mib.c   |  14 +-
> >  drivers/staging/wlan-ng/prism2sta.c   | 282 +++++++++++++-------------
> >  drivers/staging/wlan-ng/prism2usb.c   |  13 +-
> >  9 files changed, 494 insertions(+), 477 deletions(-)
> > 
> > diff --git a/drivers/staging/wlan-ng/cfg80211.c b/drivers/staging/wlan-ng/cfg80211.c
> > index eee1998c4b18..c69fb83267ef 100644
> > --- a/drivers/staging/wlan-ng/cfg80211.c
> > +++ b/drivers/staging/wlan-ng/cfg80211.c
> > @@ -130,8 +130,8 @@ static int prism2_change_virtual_intf(struct wiphy *wiphy,
> >  
> >  	/* Set Operation mode to the PORT TYPE RID */
> >  	result = prism2_domibset_uint32(wlandev,
> > -					DIDMIB_P2_STATIC_CNFPORTTYPE,
> > -					data);
> > +			DIDMIB_P2_STATIC_CNFPORTTYPE,
> > +			data);
> 
> This then violates another checkpatch warning, so you can't win :(
> 
> Just leave it as-is, it's fine, right?  Coding styles are there to make
> things easy to read and understand, and the code is fine like this.
Ok, perfect. I understand thanks. I'll move on to my next "first"
contribution then. :-)
> 
> So don't move arguments to the left of the '(' character on the line
> above please.
> 
> thanks,
> 
> greg k-h
