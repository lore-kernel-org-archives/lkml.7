Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DATE_IN_PAST_96_XX,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC9AC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BAC520879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 13:17:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="pbpNOztt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfENNRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 09:17:00 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44489 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfENNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 09:16:59 -0400
Received: by mail-ed1-f68.google.com with SMTP id b8so22816957edm.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 06:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HU2OhhRwtLlO2grDKgyXrqHwCvITV5s+KpEjai5SUIw=;
        b=pbpNOzttqK4OLvPFTIqSdzUugV654BOzlZHH5NQ9Z7kpBCx1qWuscsBsxAyd4NsK7j
         6VPUqvLJ7vjDmP++FqVqm+6MaJFlGKVPLNT8vz+W99Q1EV4PN+GIxlyl92lRtA81pRKj
         3T0TlzlT6mva4C57dA8zJSHlPna1eTIj6ox5T/RM1lFRDKuo2j/gdGKfFTNNLIR4YSnT
         kizeyg38zxZeV4mn6qH+fLm4/A/0m0dh4MGIzAtUAJX7tDZqzV0O3xPbxzdycgvGydsA
         dtuKic1mbhOBRvcX9K9/qLakrDE7XTwlvWsMFojFQ6KNOW7/kvKR5QDcatVcmDZXLfLF
         vHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HU2OhhRwtLlO2grDKgyXrqHwCvITV5s+KpEjai5SUIw=;
        b=U50URhjUEFIbxOJ0ANLMAhMsjJJV5xRLHizrcWYOiBajVqBt4Usu9Ihk+oEsP1JVdf
         pD4beywdQbUefkePLmIvxGcdAD7aEHFKe9ppjGH/lbY7BAzIKipkE52+C3gg8sfl7i9W
         jjANKmXDMAwwwWnan3z6BY3ddQjmPD5Yj9R5uMC0S9DlIc9YzEW/8+P4/5XgpQVHefsc
         HYSBfZVOuChF/AtxivCOICSIMcjQ4twIPeTrPoGaPrCWcoVHacmpYZb6Qo9N0QjUxuu5
         rKC5MAdHvsXQmLmDUE8EsBmeTsw2If71OWoo0A1WdMzquk1Y7QePvPcrn0OLnG9qtdH1
         yTnw==
X-Gm-Message-State: APjAAAWfKeVVUYu80CndC52x4+XTA0C6I++FbjvfBv0P4zAe4db8Wfe4
        Mq5GY8uX4Xbd9sk4GTB8WKYEXrCWSh8Pdw==
X-Google-Smtp-Source: APXvYqyXwQDHp0jc9m2nkqf+K6yqtJAVQnxaRfUSmtMIwVO3YjSrnZ+KhJJ4X840ZmSEUSXVcVlD+A==
X-Received: by 2002:aa7:db50:: with SMTP id n16mr35118571edt.108.1557839817293;
        Tue, 14 May 2019 06:16:57 -0700 (PDT)
Received: from box.localdomain (mm-137-212-121-178.mgts.dynamic.pppoe.byfly.by. [178.121.212.137])
        by smtp.gmail.com with ESMTPSA id k4sm4386120edi.80.2019.05.14.06.16.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 06:16:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id F421110013E; Thu,  9 May 2019 14:13:43 +0300 (+03)
Date:   Thu, 9 May 2019 14:13:43 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Justin Piszcz <jpiszcz@lucidpixels.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: 5.1 kernel: khugepaged stuck at 100%
Message-ID: <20190509111343.rvmy5noqlf4os3zk@box>
References: <002901d5064d$42355ea0$c6a01be0$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002901d5064d$42355ea0$c6a01be0$@lucidpixels.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 09, 2019 at 05:54:56AM -0400, Justin Piszcz wrote:
> Hello,
> 
> Kernel: 5.1 (self-compiled, no modules)
> Arch: x86_64
> Distro: Debian Testing
> 
> Issue: I was performing a dump of ext3 and ext4 filesystems and then
> restoring them to a separate volume (testing)-- afterwards I noticed that
> khugepaged is stuck at 100% CPU. It is currently still stuck at 100% CPU, is
> there anything I can do to debug what is happening prior to a reboot to work
> around the issue?  I have never seen this behavior prior to 5.1. 
> 
> $ cat /proc/cmdline
> auto BOOT_IMAGE=5.1.0-2 ro root=901 3w-sas.use_msi=1 nohugeiomap
> page_poison=1 pcie_aspm=off pti=on rootfstype=ext4 slub_debug=P
> zram.enabled=1 zram.num_devices=12 zswap.enabled=1 zswap.compressor=lz4
> zswap.zpool=z3fold
> 
> $ 5.1 .config attached: config.txt.gz
> 
> $ attachment: graphic.JPG -> graph of the processes, dark green ->
> khugepaged
> 
> $ top
> 
>   PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ COMMAND
>    77 root      39  19       0      0      0 R 100.0   0.0  23:29.27
> khugepaged
>     1 root      20   0  171800   7832   4948 S   0.0   0.0   1:25.59 systemd
>     2 root      20   0       0      0      0 S   0.0   0.0   0:00.02
> kthreadd
>     3 root       0 -20       0      0      0 I   0.0   0.0   0:00.00 rcu_gp
>     4 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> rcu_par_gp
>     6 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> kworker/0+
>     8 root       0 -20       0      0      0 I   0.0   0.0   0:00.00
> mm_percpu+
> 
> Thoughts on debugging / before reboot to clear this up?

Could you check what khugepaged doing?

cat /proc/$(pidof khugepaged)/stack
