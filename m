Return-Path: <SRS0=bFUY=XM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E47C4CECD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74487214AF
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Sep 2019 12:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="hIFydeMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbfIQM0l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Sep 2019 08:26:41 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:54111 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfIQM0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Sep 2019 08:26:41 -0400
Received: by mail-wm1-f65.google.com with SMTP id i16so1011513wmd.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Sep 2019 05:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=8G6S3cshgPA48meEAaZ6NSKpV8wAh+/bom1QFfZg+RA=;
        b=hIFydeMfygJz22yMIDmH7G/SPEFOrklOxvSQP+jo+P+A5kKrlT5Ivuh8ziytJqooaI
         K16M1vOzyhLPD5Te49Wtkb9gOE5fyiM1cGm3zVyRurlIXT38Mk8At7KKhxand9TKUYU+
         06fiAW1Ag3Hu5bvd97nkhjfsp1OVxgZw6j66lL6i1IxzE/xr3b29eq0cks3t4suWayH8
         toDRbMNtDpcesjYIVFVijqkIGTX/WXpWlw/tr/vlUAEJwBZDfz4PIXdX8xIbJnHoXKZE
         LpI3oPCV0DQLE7Ky1iMmX84A26KjwV4AZmHDTnqr3p78joplgBcXP2kQfu5a/idl9wW9
         I0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=8G6S3cshgPA48meEAaZ6NSKpV8wAh+/bom1QFfZg+RA=;
        b=QeWWig+hKstmWegHO3OFrf6qAXwKmCur/Hiw6Z7qEB5O9VYR1SqVWRIwFaC7t/VhEg
         jtQRwFgjMD+jKNGLiyKz1UP0FU4hWHzBX02W2JCti5g3XU3uKyQC1yKxhiYoIosE7p4W
         /65+/DhHzi2PlFCHKubORTzb7UpAvrCyV12ZJ2aUiZ1Lx0nMyfnAqWU7oyd7b3hFmS5b
         HdRqbXREyyW2cGXg+DXSPxtYRMHAod2QerheqrShvmlXygIMH7+d4zgBl2qNQRZKyaML
         Ju9AiD0I3cjBQUpS9+uZfRDYLRRhNcKkm8Ko91ep0RAzPVV7jebt03WCW4mD+bWUSFWT
         AEhA==
X-Gm-Message-State: APjAAAXMSONnxwxfbLmilJKAgtICYEqFxUPoEJqTum2vrZbUHK5nEAWX
        QJUyPSE39cwBOlD6khr00OKLoL80Uqc=
X-Google-Smtp-Source: APXvYqwjU1Ui1UMRe9RLZl8pcHFR82mLoJ27NKFfFLY/3m80s2ombZrFfKK0FAQu/FR/MBeFpnLGEQ==
X-Received: by 2002:a1c:dd0a:: with SMTP id u10mr3289081wmg.100.1568723199690;
        Tue, 17 Sep 2019 05:26:39 -0700 (PDT)
Received: from localhost ([195.200.173.126])
        by smtp.gmail.com with ESMTPSA id w12sm3314438wrg.47.2019.09.17.05.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 05:26:39 -0700 (PDT)
Date:   Tue, 17 Sep 2019 05:26:38 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Marc Zyngier <maz@kernel.org>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Darius Rad <darius@bluespec.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net
Subject: Re: [PATCH] irqchip/sifive-plic: add irq_mask and irq_unmask
In-Reply-To: <20190916223323.07664bc2@why>
Message-ID: <alpine.DEB.2.21.9999.1909170525170.30255@viisi.sifive.com>
References: <3c0eb4e9-ee21-d07b-ad16-735b7dc06051@bluespec.com> <mhng-df6c7aad-d4fd-4c44-96c8-bf63465e0c97@palmer-si-x1c4> <20190916223323.07664bc2@why>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Just tested this on the SiFive HiFive Unleashed.  Seems to work OK; 
however I did not stress-test it.

Tested-by: Paul Walmsley <paul.walmsley@sifive.com> # HiFive Unleashed


- Paul


# !cat
cat /proc/interrupts 
           CPU0       CPU1       CPU2       CPU3       
  1:          0          0          0          0  SiFive PLIC   5  10011000.serial
  3:          0          0          0          0  SiFive PLIC  51  10040000.spi
  4:       6266          0          0          0  SiFive PLIC   4  10010000.serial
  5:        102          0          0          0  SiFive PLIC   6  10050000.spi
  6:         37          0          0          0  SiFive PLIC  53  eth0
IPI0:      1134      21128       9024     220261  Rescheduling interrupts
IPI1:        10        143         18          7  Function call interrupts
IPI2:         0          0          0          0  CPU stop interrupts
#
