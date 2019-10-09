Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C784C47404
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AE6020B7C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 06:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTlI8/GP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbfJIGgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Oct 2019 02:36:08 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21385 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726765AbfJIGgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Oct 2019 02:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1570602966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:openpgp:openpgp;
        bh=DRp1swJmLGnIlAf7XMxEoZkdOJe88OuGnn8pzjWNfwY=;
        b=dTlI8/GPtYwwsf+nU2stxBoJcqKu6iGbyEq/8S7Cm2RwS1TeTui0KwY6HZwRihJl7MRt4M
        G5cyu2TNxjMRdLV3/cR/0ICiuYuaPSohr5WwvGG6PGA1FG+5u9nEjMP1WoXnij0rVJTJnA
        /vop3ROPGrTVfSnfoP5aTDGPjySAhlo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-lhVvG0z2PfCTWPvxSUFu0Q-1; Wed, 09 Oct 2019 02:36:04 -0400
Received: by mail-wr1-f69.google.com with SMTP id c17so616239wro.18
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 23:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DRp1swJmLGnIlAf7XMxEoZkdOJe88OuGnn8pzjWNfwY=;
        b=qSf3EhfYNaqynyTMLQi1rS2OHBDGDllglBhbPxoVolXLJtWr2VkbJyxeyI76ciPjkd
         Jjd/kQ9KxIkhC6Cgwh5PODKo6xK0WUtL//X3WzrOYADD73qudNdNc11gYL1TVVaXEqUS
         91jRgj0AMCpSaCnMKYCft/bRYPU2v6W/LMdGlQBNChCH8RP0qj6vmlURQhp5brk1lMwW
         O3Q/NkgyQHCmMwpHyRC0HFbdynPOJWOHXzr6VMwHRhkwC/BTPHwUUoOGmo0emWSYfnAM
         22KARxDIMdHRKqC8dUMBo1ZHnsenbYR97jH9VTlBElT4GX01gXg1mf1S2d8OnR4FZQgk
         yUGQ==
X-Gm-Message-State: APjAAAVz/1Usx0z6lVXI6yyI/l7TWmIBgR6vy9u0tIEgA4r8kOlc+0c8
        t67WVZS/rHneXYdVDUCRBvcJKbiZQpsnKXr2ZBbejczbpT8TJovEWtRXhjykcs+Og1zytA0XQU3
        d5NfFcoq6XjABbNjrnzR7O/5P
X-Received: by 2002:a5d:5610:: with SMTP id l16mr1515934wrv.143.1570602963412;
        Tue, 08 Oct 2019 23:36:03 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwIwCawDi6R5bC55JQUaG89aKMEczYrGrPl67xVSkSyIT2j1JE6iE4/baYaPJLh4Q90kl9l8Q==
X-Received: by 2002:a5d:5610:: with SMTP id l16mr1515916wrv.143.1570602963107;
        Tue, 08 Oct 2019 23:36:03 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4b0:55d4:57da:3527? ([2001:b07:6468:f312:f4b0:55d4:57da:3527])
        by smtp.gmail.com with ESMTPSA id m7sm993787wrv.40.2019.10.08.23.36.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 23:36:02 -0700 (PDT)
Subject: Re: [RFC PATCH v3 4/6] psci: Add hvc call service for ptp_kvm.
To:     "Jianyong Wu (Arm Technology China)" <Jianyong.Wu@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "yangbo.lu@nxp.com" <yangbo.lu@nxp.com>,
        "john.stultz@linaro.org" <john.stultz@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Will Deacon <Will.Deacon@arm.com>,
        Suzuki Poulose <Suzuki.Poulose@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Steve Capper <Steve.Capper@arm.com>,
        "Kaly Xin (Arm Technology China)" <Kaly.Xin@arm.com>,
        "Justin He (Arm Technology China)" <Justin.He@arm.com>,
        nd <nd@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190918080716.64242-1-jianyong.wu@arm.com>
 <20190918080716.64242-5-jianyong.wu@arm.com>
 <83ed7fac-277f-a31e-af37-8ec134f39d26@redhat.com>
 <HE1PR0801MB1676F57B317AE85E3B934B32F48E0@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <629538ea-13fb-e666-8df6-8ad23f114755@redhat.com>
 <HE1PR0801MB167639E2F025998058A77F86F4890@HE1PR0801MB1676.eurprd08.prod.outlook.com>
 <ef6ab8bd-41ad-88f8-9cfd-dc749ca65310@redhat.com>
 <a1b554b8-4417-5305-3419-fe71a8c50842@kernel.org>
 <56a5b885-62c8-c4ef-e2f8-e945c0eb700e@redhat.com>
 <HE1PR0801MB1676115C248E6DF09F9DD5A6F4950@HE1PR0801MB1676.eurprd08.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <1cc145ca-1af2-d46f-d530-0ae434005f0b@redhat.com>
Date:   Wed, 9 Oct 2019 08:36:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <HE1PR0801MB1676115C248E6DF09F9DD5A6F4950@HE1PR0801MB1676.eurprd08.prod.outlook.com>
Content-Language: en-US
X-MC-Unique: lhVvG0z2PfCTWPvxSUFu0Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/10/19 07:21, Jianyong Wu (Arm Technology China) wrote:
> As ptp_kvm clock has fixed to arm arch system counter in patch set
> v4, we need check if the current clocksource is system counter when
> return clock cycle in host, so a helper needed to return the current
> clocksource. Could I add this helper in next patch set?

You don't need a helper.  You need to return the ARM arch counter
clocksource in the struct system_counterval_t that you return.
get_device_system_crosststamp will then check that the clocksource
matches the active one.

Paolo

