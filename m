Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAF1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F79C20857
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 10:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="dyTOgN2g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfCSKVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 06:21:49 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37915 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfCSKVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 06:21:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id g1so7228732qki.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2019 03:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rEpkfPsDj23CwxfUKV9E2hJWjwLh0d9UFa4vQefOAfg=;
        b=dyTOgN2gVc6jqEdIB9qe2fmz8nLewsCTPtDg8S3oq8dbL6rqacVYro+uDi5LyrQ1Xd
         fY3vlkYP6YghXiWHK0MQhJjQ6+xfTqLEiAGwSl7EV6BxlNDRF0u8vx+NwldqTBn2FyAr
         jXwt597etXhnABb17P2lH0C096XfUleFWoq5tMFA6VRPvvu+aIUZLiS+DrpDXVRavsvF
         /lPGq1/KrUPAsygBu64pN2pPS7B0L17ijKU/1tUFddle1GxBHey6axyADRo17LaHucD8
         Z7z4ogPuuXgR8bJB72t9S2SPoJadvDXGb4QABdWGbNvXJhPvxqY9Mr3NVABkYuwAMmtR
         lw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rEpkfPsDj23CwxfUKV9E2hJWjwLh0d9UFa4vQefOAfg=;
        b=OVvKruBDN5v+MFl5ZJETMM/eCt3QHR3lOqavYlb+691DTUeuhEpH6WWA7ICvZIAd6Y
         YgVOkqe0DaEpNdQGE5XpE99kz8rbZD6DhzIwF/wwX2d1bxOFr8IUSHhqTsCH9PBdjEMO
         FOt+cXBQz3mql99/J2OtyrKeGaGqYw/hMRdJPTL1l1Mwf1rikN8/wT9XYbqD0a7plVDK
         y9uCE5ipJcOxWbFh8NQIITG6UG0cV6EvZMh47fEXOJkeygh9LIHAnfTFqRTMPntgwdNj
         BQWPj8rLn/0Duxc29YY0kbnkYa5+bNWhemQFuuFBjfyXCgP2I+snL1XiVFrzZtrcd82x
         C7TQ==
X-Gm-Message-State: APjAAAX5L2vnME8Sd1fdQf9KYIbzml1QCCMU8b34lA9AlcrBCQPe6jIR
        6ziNDWVWxNNP7Zif72e9e5Bg2shha8c=
X-Google-Smtp-Source: APXvYqy598D9NuNFngcL/ofJCThxLNW9mD8tMUsgeOO4NgPewZtExABDQT0MJlLcUSaC3PptIIW9sw==
X-Received: by 2002:a05:620a:1352:: with SMTP id c18mr1110704qkl.303.1552990905802;
        Tue, 19 Mar 2019 03:21:45 -0700 (PDT)
Received: from ovpn-120-94.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x29sm7970832qtm.74.2019.03.19.03.21.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 03:21:45 -0700 (PDT)
Subject: Re: [RESEND PATCH v2] powerpc: mute unused-but-set-variable warnings
To:     Christophe Leroy <christophe.leroy@c-s.fr>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20190317220516.92654-1-cai@lca.pw>
 <1ffdc5ae-2d5f-6c81-3997-0e6c81c67516@c-s.fr>
From:   Qian Cai <cai@lca.pw>
Message-ID: <b3e7d016-74ca-aaaa-02e7-39fbc2200013@lca.pw>
Date:   Tue, 19 Mar 2019 06:21:43 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <1ffdc5ae-2d5f-6c81-3997-0e6c81c67516@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/19/19 5:21 AM, Christophe Leroy wrote:
> Is there a reason for resending ? AFAICS, both are identical and still marked
> new in patchwork:
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=76055
> 

"RESEND" because of no maintainer response for more than one week.

> Indeed, the resend has an issue in the commit log and fails the checkpatch (a ::
> in Reviewed-by::)

Yes, my bad for a copy-and-paste error.
