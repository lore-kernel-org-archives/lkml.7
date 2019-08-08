Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2ABBC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1D0A2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 19:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVYZ29bT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390252AbfHHTit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 15:38:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:32798 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732327AbfHHTit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 15:38:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id n9so96164230wru.0;
        Thu, 08 Aug 2019 12:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YoS8PRw3cjholKW72Wo5FIMucVCjxsoQPkOGGlFKOFU=;
        b=DVYZ29bTj1ljfEsoUcWARgkYX2a4poFVfmPZkcpwyFgCBscv1sJzBoN2rImkmEQ36a
         UKXvtxWK0SY7Dr5/gYGDxjmZhKBtbrMMBd26c+29N8+W07gm6IJQB//53uo8v+YbxuZV
         GgSJM1+PNsPdyLGrHpVm+UBMMrbrzWJO+KOyBkCOeQobGIIz9cIr5wJX0FyJuzklHEVi
         JSNos6MPi4gmJeY7OtqtHmRc+gs8eTpvd6HagOkCGLjbxOv4XltWt1JqSoDQZo296gd8
         9Uh7q083ScfjbIcltUi1fT2d+CnuUJpE8vaQJEm6xOkgKcf5vM29uN0HwVlym/8ImXJ9
         +rmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YoS8PRw3cjholKW72Wo5FIMucVCjxsoQPkOGGlFKOFU=;
        b=I0a2lLdircUKym37q2P+vGSF7ubDsabqL7ipqypL9Oa1VysM47cUtfF/Gu/tVnOtd1
         YA6g3/mS14Jjgpj/EBpl21leGkFdpRJbOV9lBQqzgK6LDeyLKJlS98HrtkQPt9AyHsZO
         q1Oh7lscFdRpMO+qnCWNXD51MWpI7z0PRdkJayD5cPQRizLP1WngAsA27VRSB5/ISLWC
         PRnA/HTyR+XcpjEy/CIQpmjKQ66MnM9uCE3CpG9WYhppCnSWTzPhoE2FCUAF3VKGkgDX
         D8FL0cLAP0iGCaiPFezBAuddB3xOKwpNN9r62xgztFMpwDMnKzXFWevKzSEhnomB3vvs
         Ymkw==
X-Gm-Message-State: APjAAAWcS3Sng+L/ZWp95LRf17+QFrMnRDteWMIYWhicha7NSF4t9KeK
        ugxOFSqySVk7ntZrTvgayAs=
X-Google-Smtp-Source: APXvYqxk2r1+U9UcqqJldtJvlXj7yg5APuFEK4cNWKSEBrXzlvkV+3YyhG2ik8OQub5VRW/w/DhsqQ==
X-Received: by 2002:adf:f04d:: with SMTP id t13mr18922037wro.133.1565293126711;
        Thu, 08 Aug 2019 12:38:46 -0700 (PDT)
Received: from ?IPv6:2003:ea:8f2f:3200:ec8a:8637:bf5f:7faf? (p200300EA8F2F3200EC8A8637BF5F7FAF.dip0.t-ipconnect.de. [2003:ea:8f2f:3200:ec8a:8637:bf5f:7faf])
        by smtp.googlemail.com with ESMTPSA id g15sm2924126wrp.29.2019.08.08.12.38.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Aug 2019 12:38:46 -0700 (PDT)
Subject: Re: [PATCH v2 02/15] net: phy: adin: hook genphy_read_abilities() to
 get_features
To:     Andrew Lunn <andrew@lunn.ch>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davem@davemloft.net,
        robh+dt@kernel.org, mark.rutland@arm.com, f.fainelli@gmail.com
References: <20190808123026.17382-1-alexandru.ardelean@analog.com>
 <20190808123026.17382-3-alexandru.ardelean@analog.com>
 <20190808152403.GB27917@lunn.ch>
From:   Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <eeda87c9-bdba-8ef7-6043-85a16bd2cfc2@gmail.com>
Date:   Thu, 8 Aug 2019 21:32:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190808152403.GB27917@lunn.ch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.08.2019 17:24, Andrew Lunn wrote:
> On Thu, Aug 08, 2019 at 03:30:13PM +0300, Alexandru Ardelean wrote:
>> The ADIN PHYs can operate with Clause 45, however they are not typical for
>> how phylib considers Clause 45 PHYs.
>>
>> If the `features` field & the `get_features` hook are unspecified, and the
>> device wants to operate via Clause 45, it would also try to read features
>> via the `genphy_c45_pma_read_abilities()`, which will try to read PMA regs
>> that are unsupported.
>>
>> Hooking the `genphy_read_abilities()` function to the `get_features` hook
>> will ensure that this does not happen and the PHY features are read
>> correctly regardless of Clause 22 or Clause 45 operation.
> 
> I think we need to stop and think about a PHY which supports both C22
> and C45.
> 
> How does bus enumeration work? Is it discovered twice?  I've always
> considered phydev->is_c45 means everything is c45, not that some
> registers can be accessed via c45. But the driver is mixing c22 and
> c45. Does the driver actually require c45? Are some features which are
> only accessibly via C45? What does C45 actually bring us for this
> device?
> 
genphy_c45_pma_read_abilities() is only called if phydev->is_c45 is set.
And this flag means that the PHY complies with Clause 45 incl. all the
standard devices like PMA. In the case here only some vendor-specific
registers can be accessed via Clause 45 and therefore is_c45 shouldn't
bet set. As a consequence this patch isn't needed.

>      Andrew
> 
Heiner

