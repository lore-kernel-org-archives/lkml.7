Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B637C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 103E120651
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:34:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Kf59bzCj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbfDOTeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:34:46 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:35990 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728061AbfDOTep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:34:45 -0400
Received: by mail-oi1-f195.google.com with SMTP id l203so14854748oia.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2019 12:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=YgR4anGJYWT87aHsH2653ivpThZkVAfEIrVsIg/UD+w=;
        b=Kf59bzCjjVWDrT23LS91GLArNsBHC7AH2aS1g8JT7qJMuZx7fE6sWPWTsX8HGznHcJ
         l/nVU9CPjCS003poyu0cRJ+eB8GA98tvQfKhiakdHlObAGtupT/pzyENx4Diid2rsZcW
         m457ivth0mvj1sNZhf8CVbtD6nagq9Kwwv9pcQT3fg6H0XbVITJz9mgdoZ4cbumCjMTf
         BOPUyndIlInvqqgdr7iHlQ1GnPgQdVschnAF2iKdwmIRbHL5jyDopHFeor3yqBTCmAON
         0wlR51qt6s3M22hdujvQ3b88dVcg96eUTTPmJFIjP4FwWiZVQJXpy6PjUkKkoqdVou0a
         adQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=YgR4anGJYWT87aHsH2653ivpThZkVAfEIrVsIg/UD+w=;
        b=tZBFC81H614LgF6zK6JCyqP+FMrM6tqSC4RwwU34MadGkJ3KoJxH5/imzT/mrhLA0E
         hPT4HNVb4+hpxYJ2MllmQ0jIPziQJSEefrWjaWr57EpvsW6GqDPbwuAmMQAsWqhUYCuB
         OsBFq19a4NgSYomQT1IhnfWe7AdixN4PazbbGqhIJcucJN7d40erKFdsiB8hXhkIRdLX
         OdXsCjzVWnwN+a28PEahlQDwHZTEPVirOfZqH62Ge1lvsay/uuSopF4ZcJ2RxDJwRRXG
         gXy76Cje2DWTkgLVtYSeJJ06pfGZCAvpHGODKcIWl9KOtu+GTgMKP0gZ1t0sC+otInRL
         g2Og==
X-Gm-Message-State: APjAAAVhawfTjxqwv1i/Z6/nr1oBt8ZDATgTJxS9APbye4tJ0oh524yL
        E/qkbShw7VCc6Bp1hUxmb/5xd/2fRTZmm0EtR3yyXg==
X-Google-Smtp-Source: APXvYqwYwPusDp5uVSJaWLnTWru1zhIH0MvwRAlXxGJNalOTTeCQ30tp1c4vb/cTAmQsDUlfueZtiGVy5+jwSvqXY+o=
X-Received: by 2002:aca:d513:: with SMTP id m19mr20225773oig.73.1555356884829;
 Mon, 15 Apr 2019 12:34:44 -0700 (PDT)
MIME-Version: 1.0
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 15 Apr 2019 12:34:33 -0700
Message-ID: <CAPcyv4g97hof42jNAx__GpZ9ATPLv4J2AFo56nRzH-whCj7vgg@mail.gmail.com>
Subject: [GIT PULL] Fileystem-DAX fix for v5.1-rc6
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/fsdax-fix-5.1-rc6

...to receive a single filesystem-dax fix. It has been lingering in
-next for a long while and there are no other fsdax fixes on the
horizon.

---

The following changes since commit e4b3448bc346fedf36db64124a664a959995b085:

  dax: Flush partial PMDs correctly (2019-03-01 17:24:48 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm
tags/fsdax-fix-5.1-rc6

for you to fetch changes up to 11cf9d863dcb583345723b0ed72173348761e9c0:

  fs/dax: Deposit pagetable even when installing zero page (2019-03-13
13:58:46 -0700)

----------------------------------------------------------------
fsdax fix 5.1-rc6

- Avoid a crash scenario with architectures like powerpc that require
  'pgtable_deposit' for the zero page.

----------------------------------------------------------------
Aneesh Kumar K.V (1):
      fs/dax: Deposit pagetable even when installing zero page

 fs/dax.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)
