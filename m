Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C45C2C10F06
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A992077B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 20:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mbuki-mvuki-org.20150623.gappssmtp.com header.i=@mbuki-mvuki-org.20150623.gappssmtp.com header.b="YjrKN8ZC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfCNU5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:57:21 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43143 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727246AbfCNU5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 16:57:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id d17so7346626wre.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 13:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbuki-mvuki-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0n+Yubwo3+VmfuEyCVcIzcBbnEVd7iC+Fb5ALd0vzzg=;
        b=YjrKN8ZC41ArPSrj0jEaqlU4YzOOpZoWqbYM/ehGIDZKXKseeyLuCWiEWRB/90obzT
         Iqdf02pwGiJTvBTjeB0V2RTpojLOPRyNeYT3PHdfG/2O6TbBmp3A46XSinGJwZrf4JSG
         He7i12HS/Gkv0Pg/gA22aQYD+VNGqsC9ECUlwc43t7NBOlpuoHkE5Hx7PdM53YxzQ6FG
         BVum16oZFCTwWPfRzVYgXe1O5fWazUbGYoGBkh53uDT6qjCTJnL2TCOA+4VPqLLMpFXw
         RMnCVeJCsGaaDZaQgMvvotdbkDxDJr6SINUpwzJ2q1efNPcv8fYeZ3jyYSSRGCqh2JH0
         SJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0n+Yubwo3+VmfuEyCVcIzcBbnEVd7iC+Fb5ALd0vzzg=;
        b=L/KoSS2UW6OyBC8y1jI2rfmhpnaMzb3b6lvqk64AZJmQ5RDeW2/HnceRdiT7sCwYh+
         d5wRieR/lxh9ZwTTKF/fQiSstX0KWd00kDOmB5m8MRnsVWbiSq2L2FjzGF+DkpWEVDq7
         Vc2wIGdbc3jkPtrLlVKc4azqorzakvAufqeTXTuCO3iirxyx4972LgmYrtthrqyOFN/2
         j1KVtcbvmM9buWZSsvVZxmtJnQpmn1esDc/OlCfQjASI8ufsVsHbtmvtfthrcazVoSlg
         AKC8Nih0L6ywryFhylKmDQsSJj11/zCVVR2kKEIfKtsqz9dIghqSJk0zi4+jNRBWfAZv
         HZUA==
X-Gm-Message-State: APjAAAVxG5LZVHohyUTeK8nM8MYv0nUzYvPnLBpIbOB+RZLgv4WFBNib
        RSE+QECcdUCxVzhLpzQVQ6Hk3HMHv0TAUw7n8TUPsQ==
X-Google-Smtp-Source: APXvYqw0lPXN5Zx+E9zkLIeQwjb6vF8nfptwMRMufVE6lctcBMaNIw0IVzBD+zS7E5O86tPrDgwB0rLfvRGHrp7bq/E=
X-Received: by 2002:adf:9065:: with SMTP id h92mr393712wrh.150.1552597039322;
 Thu, 14 Mar 2019 13:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <CANSNSoWiKd98Dt1N2sSjP9Af8zk1NPV-=3P4VLtFs_cSQG4RUg@mail.gmail.com>
 <20190313232112.GC210027@google.com>
In-Reply-To: <20190313232112.GC210027@google.com>
From:   Jesse Hathaway <jesse@mbuki-mvuki.org>
Date:   Thu, 14 Mar 2019 15:57:07 -0500
Message-ID: <CANSNSoXPFDu9RQAUA6dUCUrSCAj68q-Nj2W7ECz3fKpFtSNU+Q@mail.gmail.com>
Subject: Re: Regression causes a hang on boot with a Comtrol PCI card
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 1302fcf0d03e (refs/bisect/bad) PCI: Configure *all* devices, not just
> > hot-added ones
> > 1c3c5eab1715 sched/core: Enable might_sleep() and smp_processor_id()
> > checks early
>
> How did you narrow it down to *two* commits, and do you have to revert
> both of them to avoid the hang?  Usually a bisection identifies a
> single commit, and the two you mention aren't related.

Sorry I should have been more verbose in what the bisection process was, I
found the problem after attempting to upgrade from linux v3.16 to v4.9. When
v4.9 hung I tried the latest kernel, v5.0, which also hanged. I began a git
bisect, but found there was more than one bad commit. Here is my current
understanding:

- [x] v3.18 vanilla, 1302fcf0d03e committed, hangs
- [x] v3.18 with revert of 1302fcf0d03e, works
.
.
.
- [x] v4.12 vanilla, hangs
- [x] v4.12 with revert of 1302fcf0d03e, works

- [x] v4.13 vanilla, 1c3c5eab1715 committed, hangs
- [x] v4.13 with revert of 1302fcf0d03e, hangs
- [x] v4.13 with revert of 1c3c5eab1715, hangs
- [x] v4.13 with revert of 1302fcf0d03e & 1c3c5eab1715, works

- [x] v5.0 vanilla, hangs
- [x] v5.0 with revert of 1302fcf0d03e & 1c3c5eab1715, works

> Can you collect a complete dmesg log (with a working kernel) and
> output of "sudo lspci -vvxxx"?  You can open a bug report at
> https://bugzilla.kernel.org, attach the logs there, and respond here
> with the URL.

Bug submitted along with the requested logs,
https://bugzilla.kernel.org/show_bug.cgi?id=202927

> Where does the hang happen?  Is it when we configure the Comtrol card?

Hang occurs after PCI is initialized, snippet below, I have included the full
output in the bug report:

[   10.561971] pci 0000:81:00.0:   bridge window [mem 0xc8000000-0xc80fffff]
[   10.569661] pci 0000:80:01.0: PCI bridge to [bus 81-82]
[   10.575594] pci 0000:80:01.0:   bridge window [mem 0xc8000000-0xc80fffff]
[   10.583278] pci 0000:80:03.0: PCI bridge to [bus 83]
[   10.589008] NET: Registered protocol family 2
[   10.594254] tcp_listen_portaddr_hash hash table entries: 65536
(order: 8, 1048576 bytes)
[   10.603671] TCP established hash table entries: 524288 (order: 10,
4194304 bytes)
[   10.612729] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[   10.620446] TCP: Hash tables configured (established 524288 bind 65536)
[   10.628124] UDP hash table entries: 65536 (order: 9, 2097152 bytes)
[   10.635541] UDP-Lite hash table entries: 65536 (order: 9, 2097152 bytes)
[   10.643669] NET: Registered protocol family 1

Please let me know if there is anything else I can provide, I am also happy to
test any patches, Jesse Hathaway
