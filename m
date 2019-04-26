Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DCAC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7D02077B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 15:55:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="S0wsh0Vn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbfDZPzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 11:55:15 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34792 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbfDZPzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 11:55:15 -0400
Received: by mail-qk1-f196.google.com with SMTP id n68so2182694qka.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 08:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M1KaF+DSCnWN8ZthCrAegiw+U4FUrxW5sRpTIk7RM0M=;
        b=S0wsh0VnxEBNrOgR+67oYarfPiEP7S7R+Sdd8KeHAAaJIk49JL0RiKgjzFiz0J+Z7P
         7FyyVZ9J20UFX5rkf3W3JyYfD9Oqty0UN6WBfZf6i+hhUYGUte42+trt6sUJdYAZcA9O
         DN0i3LDJsYWLfhWZwrVLHEbcWi7a6Iv6D6YzvKE7Jzg4PnVPEpMZ1+P9Qbi0jEEJabEO
         CvL2kW60B2OVjW02WR4zlVFQW7LQEuCDRq88jKt24rEkLL6LQbHLIcVBFTSFoGlio/Zm
         GX0l53jp62D1xByx7mB7GZ7ramo+jiLQtdLZ7mgjMU+Hj8OPNDPphbWu0ixWlR4QfFxb
         l/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M1KaF+DSCnWN8ZthCrAegiw+U4FUrxW5sRpTIk7RM0M=;
        b=KH9GNPYJS0DuTkX46g5I16uZlkmzRr/fxBQ+8ETf5hksWrowTlB7OM5FQXF/2sCr5d
         d8c6gZwA1a0AJWShUmzPNqxvZvSOcW/qBn3Oy67j3Z7EA0ZP2KiP2TAttfhIsucAveiY
         ti6nso4uk1F7+H8KkA/kfaVUpURPBCdP30DzG5PO/xuA03kdTIoowZjGawA9w+nRtTor
         tHxE5LcAAcHX5xvX3viIQjvlgOKWonr16snouM4PzidumaldffXNSUCdA32BA1+RhJ+P
         EwF9TCmPG9IQEz19RcYg2l0OXsR62cOvJchZjVGr+0/xCGRpLsq9VSmkoiH+PQTAzOOn
         j39Q==
X-Gm-Message-State: APjAAAXhhlLCaqy0sCmQTORAy1FjvcyYU2TFn/oFrM88ELxEH/dr+psY
        217tu7dDs1Z2upwf3/p19DeOpQsiXWQ=
X-Google-Smtp-Source: APXvYqx0B6IxCHYVAJC79ZkHE7/H1twzINBweRC6BFRaN13IwzSa46wZ5jQHJLliIdFBcUh2sVD2uQ==
X-Received: by 2002:a37:484c:: with SMTP id v73mr35618564qka.37.1556294114426;
        Fri, 26 Apr 2019 08:55:14 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a1sm5063373qkn.58.2019.04.26.08.55.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Apr 2019 08:55:13 -0700 (PDT)
Message-ID: <1556294112.6132.7.camel@lca.pw>
Subject: Re: "iommu/amd: Set exclusion range correctly" causes smartpqi
 offline
From:   Qian Cai <cai@lca.pw>
To:     Joerg Roedel <jroedel@suse.de>
Cc:     iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 26 Apr 2019 11:55:12 -0400
In-Reply-To: <20190426152632.GC3173@suse.de>
References: <1556290348.6132.6.camel@lca.pw> <20190426152632.GC3173@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 17:26 +0200, Joerg Roedel wrote:
> On Fri, Apr 26, 2019 at 10:52:28AM -0400, Qian Cai wrote:
> > Applying some memory pressure would causes smartpqi offline even in today's
> > linux-next. This can always be reproduced by a LTP test cases [1] or
> > sometimes
> > just compiling kernels.
> > 
> > Reverting the commit "iommu/amd: Set exclusion range correctly" fixed the
> > issue.
> > 
> > [  213.437112] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> > domain=0x0000 address=0x1000 flags=0x0000]
> > [  213.447659] smartpqi 0000:23:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT
> > domain=0x0000 address=0x1800 flags=0x0000]
> > [  233.362013] smartpqi 0000:23:00.0: controller is offline: status code
> > 0x14803
> > [  233.369359] smartpqi 0000:23:00.0: controller offline
> > [  233.388915] print_req_error: I/O error, dev sdb, sector 3317352 flags
> > 2000001
> > [  233.388921] sd 0:0:0:0: [sdb] tag#95 UNKNOWN(0x2003) Result:
> > hostbyte=0x01
> > driverbyte=0x00
> > [  233.388931] sd 0:0:0:0: [sdb] tag#95 CDB: opcode=0x2a 2a 00 00 55 89 00
> > 00 01
> > 08 00
> > [  233.389003] Write-error on swap-device (254:1:4474640)
> > [  233.389015] Write-error on swap-device (254:1:2190776)
> > [  233.389023] Write-error on swap-device (254:1:8351936)
> > 
> > [1] /opt/ltp/testcases/bin/mtest01 -p80 -w
> 
> I can't explain that, can you please boot with 'amd_iommu_dump' on the
> kernel command line and send me dmesg after boot?

https://git.sr.ht/~cai/linux-debug/blob/master/dmesg
