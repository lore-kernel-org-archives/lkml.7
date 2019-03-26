Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7159FC10F05
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C712084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 17:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQqEEXhX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732404AbfCZRtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 13:49:32 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34557 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729800AbfCZRtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 13:49:31 -0400
Received: by mail-pf1-f196.google.com with SMTP id b3so7040922pfd.1;
        Tue, 26 Mar 2019 10:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZBnGrGRVU77JF8H04VhKpey4PrW2b8Si6mHi+JPgTqo=;
        b=TQqEEXhXArhwK2YZ0UDn4Bd1BKhKpTbQwuUYNXS1Chl+MZo+3xVc2mz5tfqE0Be7n5
         eRmPicqR88cRwZ34Ib+Xs88BcfE5oTsTtbQmrOBDt4SScxe94veO0HLc1LfCtQtw0Te0
         S0S1SfcSXsHc8qbHNRJTG2MtdLdOTiUcipkYblg6HGpdTha5Q1UTXnD2TYlePDuk10wZ
         TpzdkxwxrfMk7+GAcc0C6o7TE8Frm6e05F+/j8LPeT/7l7piJh59uCxZZsPjCJxLjSlU
         3etHniHsPTfNkcABwk2li39vU0wcnl0h3Fnez7hSq7utdJQXcGoJNiY1p1l8ht4Rs68V
         F5yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZBnGrGRVU77JF8H04VhKpey4PrW2b8Si6mHi+JPgTqo=;
        b=i0+mJclpyELvACWARjaBwszUH9zryKN9NruLpqwEZp0c+PFUC/Pp67WOCNZ6hTLdWy
         k5/YC8P+03DxRU4elCBE1/GmijWz/5TQGKN1S0w3zdQ8+f2dhMg0W2ZeZNEOPByyX4U2
         JfVfH50T2GN/yFkK4IoIZ3bnxUp0QqWXFlT1ql7RXOAfC3BT5GdBOLVO9YFTDk6wzp8N
         KWL4Tgs1RyewL7HuK4SRauJvwX+sPYHNG2V/o0xneJwJI/T4r0KA8Dc0sCA+Ig5aKRBV
         y8AB4BM45y64F16+G2LTTPivTTs6zsQtNzSXp5XCy7p1wpAblnoF3YEHFOTBhIwIVVvp
         IrgQ==
X-Gm-Message-State: APjAAAXd5M6zR74EzJuP/DeJcborL24gaQxVAbL3tOmSOgMQCMSbCK2E
        vjLDV1Qd2CkUWGprVxgrts4=
X-Google-Smtp-Source: APXvYqx9w1yC4SsYx7/vmypGP4ELuwlDHnXQmA6IXgW7BjyzcCXpnkO5wCFMxJut748vM9Fi3Kl+TQ==
X-Received: by 2002:a63:2015:: with SMTP id g21mr7129082pgg.226.1553622570724;
        Tue, 26 Mar 2019 10:49:30 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t22sm25986510pgu.45.2019.03.26.10.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 10:49:30 -0700 (PDT)
Date:   Tue, 26 Mar 2019 10:49:29 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 4.14 00/41] 4.14.109-stable review
Message-ID: <20190326174929.GC9916@roeck-us.net>
References: <20190326042649.889479098@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190326042649.889479098@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 26, 2019 at 03:29:37PM +0900, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.109 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 28 04:26:32 UTC 2019.
> Anything received after that time might be too late.
> 

Build results:
	total: 172 pass: 172 fail: 0
Qemu test results:
	total: 329 pass: 329 fail: 0

Guenter
