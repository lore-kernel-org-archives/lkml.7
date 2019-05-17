Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6726AC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27F0F21734
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZMxx7nMk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbfEQVaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:30:20 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:36836 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbfEQVaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:30:19 -0400
Received: by mail-pg1-f193.google.com with SMTP id a3so3881655pgb.3;
        Fri, 17 May 2019 14:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EBFaKsqecT1MaNaHdZw4nDBl4CqjrLOqwiKCfRygg6g=;
        b=ZMxx7nMkLTn7RhNI+60IOVTJXSK8+fRCWlW+LufcMvU8cFAKhfBU8BUJ5g+NHh4YnE
         dbaIs5iDhYhgMzjCSjSCv+aE4EYSF1UUjlg6q3pWGiJcH3aw7iSHC3Triik1RGsvIINC
         xZKKm+NUP3z9Uiek4L0jH6LKSPXEwUXL0ZstNaLWNNo3yEK6fpDvxtt/Vt0FLxNOcHBc
         CTz59tCv8SXy58Hgg6oQTRlqF1piQzrMjGiZbAarqyXYCNBX1Su6oVXjieByRaTcT1hF
         R1Nrx7+qvzEzoX5c+FLFQFeHNr+wcr+GbjzparZIs+dOz/ptw8FRTNf2hS1CIK2dPYSu
         UNCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EBFaKsqecT1MaNaHdZw4nDBl4CqjrLOqwiKCfRygg6g=;
        b=tr/J9xiLZGd4DqTjqVkss9w5LuZEvIKc+H9bgn35o5Y8Z7CMPxPfrUNgDLOVmi34Bq
         Jpd7ZQbkaegYPBV/zDlC73J13cO+KP/luD55U7KWm7wfWfQFD9CBAtTmy9gdB9v6gY1X
         IT/zUI0BGNCjX3Okpo4PmjB25HTn+QG1/JCufj0afAsJjiwsFvmq0QZ030QP5Bv2jiB8
         +lRICxG9mcDcAZJqoHbTJB+R8DTjKNCVhjgPO/p2kMoGHbqwUc1TTUTZzIf6LOv0olyN
         JwMBYmUUIWUwC1CNuuD7JZ2QCOtaJBq/mFcfifdBfJLs+JQpRJJLFStDmSG8kLYoy18n
         ljBA==
X-Gm-Message-State: APjAAAXa3+yeA5k9PSMwhn98XcxInIqqYI6TPjqfZ5Xx6vRD5i/zlJNJ
        wtM929lSK+4RSRZZWI49rgQ=
X-Google-Smtp-Source: APXvYqyZdkHd5brA48SO1lFEMiElxypRyYL5X3ejQ0snhpR4IMJIpTcKwSkiCW2h44MhYKyHoKIjeg==
X-Received: by 2002:aa7:90ce:: with SMTP id k14mr62095430pfk.239.1558128618801;
        Fri, 17 May 2019 14:30:18 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id c15sm11885802pfi.172.2019.05.17.14.30.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 17 May 2019 14:30:18 -0700 (PDT)
Date:   Fri, 17 May 2019 14:30:16 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stefano Manni <stefano.manni@gmail.com>
Cc:     nick@shmanahar.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: atmel_mxt_ts - add wakeup support
Message-ID: <20190517213016.GA93581@dtor-ws>
References: <20190517211741.8906-1-stefano.manni@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517211741.8906-1-stefano.manni@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sefano,

On Fri, May 17, 2019 at 11:17:40PM +0200, Stefano Manni wrote:
> Add wakeup support to the maxtouch driver.
> The device can wake up the system from suspend,
> mark the IRQ as wakeup capable, so that device
> irq is not disabled during system suspend.

This should already be handled by I2C core, see lines after "if
(client->flags & I2C_CLIENT_WAKE)" in drivers/i2c/i2c-core-base.c.

Unless there is dedicated wakeup interrupt we configure main interrupt
as wake source.

Thanks.

-- 
Dmitry
