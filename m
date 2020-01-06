Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E052C32771
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E351821734
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 07:13:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzU5/N9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgAFHNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 02:13:33 -0500
Received: from mail-io1-f50.google.com ([209.85.166.50]:36833 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgAFHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 02:13:32 -0500
Received: by mail-io1-f50.google.com with SMTP id d15so4161755iog.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jan 2020 23:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=NJ1kzJR052MLvZPV+RVXowPHwe/9E6HoeYilC/tiByA=;
        b=dzU5/N9imBsgaWmd+vXNOkcpDAsbGOPQMzClGA/RmkWtptnB1T7jzrBNjUNaC/v9bE
         SwV50hutVosdivLRlI7cH4NkRIIJ3wDB1XD1Kbjv70qHgyGHqUmzdVFR/PFVgrYoc50p
         lHwhLkcm1Ai7KW6PS/hoJQNuw0sYrDEpm0O3sWmCcHu8UDv2Wiuy61CLO3rtGoJ0jGld
         BzDR3BHltZe57DFkkZRvnRnGuPv4IC6/GmAHMYUc79vLpvh2sisSKpEUkF9oB62eXqNU
         K4ZnLGeABwgev5zwpsrIu+Fa0sxe53PsjEBBr2patWT7+QBG0LRPTggoIXg7Tic9/ZpW
         ISeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=NJ1kzJR052MLvZPV+RVXowPHwe/9E6HoeYilC/tiByA=;
        b=hhWh5CdvSXZtbcLoayDYJdPwkEX2fDamXChqrfq1MzJ1jHylBuVZBvYaqq0i2/WvlB
         N20aTzeVe8/lOimY04oWNbAxiUNt7qR5VCNDz2rQklsHf1Ccp3prEV0e54nps6fYPHkx
         4G5dFfeCsk1QBoyxFyVtSOn0kAtaqSjytwFO+ZX8Lv7UAHzUaKO/wIBya1X41e/uAmiO
         JUXBvw40rLB0/acpBzkHix2vPuvVu1DoPQhI4WS8iKme7iU8kAXlXxevNgiZQk6eChM7
         nXnWQOFroIROJn1Lbw3c0Db8DG8tYn9zJLODC/CLFeiqCHcv1mAvbxeI+HqerOX9Q2gn
         aOrQ==
X-Gm-Message-State: APjAAAWYUbVdEb/17CQ1LtVaVz+liQsLahvM9wG2SBx4WRFYr9thJn/Z
        xWVbfU2seXx5vTfPoPRZ7e5QbuUclffN/dp5l7hcvDOnVNY=
X-Google-Smtp-Source: APXvYqy81A01ypKKtRL2pERY3sTExx6NuvbmB04SWqHluHydX0P04I+aDrRUcaFyip5bsaWBULiLqWlDjIDQxlXeO6k=
X-Received: by 2002:a5d:89c8:: with SMTP id a8mr65613148iot.186.1578294811822;
 Sun, 05 Jan 2020 23:13:31 -0800 (PST)
MIME-Version: 1.0
From:   Uday R <opensource.linuz@gmail.com>
Date:   Mon, 6 Jan 2020 12:43:20 +0530
Message-ID: <CAFZWReakYoDcSgEXw-d-SPAzum=fw=uLo7sh8OMqZV6FjP1ymA@mail.gmail.com>
Subject: Issue with Kexec memory allocation
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello folks,

I am using kexec to load into the new kernel from the existing kernel.
My vmlinuz image size is 6.6MB, initrd size is 18MB, and the root file
system size is 715MB.  I use kexec command to load the new kernel into
memory. I observed that before calling kexec if the available memory
is less than 1.33GB then kexec lands into an out of memory issue
effectively kexec being killed by OOM-KILLER.  I dont get into out of
memory issue if i have memory >=1.33GB.

My question is why kexec tries to over allocate memory when the
available memory is less than 1.33GB and gets the available memory to
ZERO.
In case if the available memory is >= 1.33GB before calling kexec,
After kexec load, i see the memory consumed by kexec load is
approximately equal to size of "linux+initrd+root file system".

Is there a bug in the 'Kexec' code and had been fixed ?

Note: i am using the kernel from a vendor, Just wanted to know if
there is no such issue in mainstream code.

Thanks in Advance,
Uday
