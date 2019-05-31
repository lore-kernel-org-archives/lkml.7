Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE254C28CC3
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74B42529E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 16:52:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="OG1KV6FZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726998AbfEaQwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 May 2019 12:52:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42565 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfEaQwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 May 2019 12:52:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id y15so7051651ljd.9
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2019 09:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v6H5MAo72kBrswxB03BJ2HpgepSBZLZhL5ogd8zupLU=;
        b=OG1KV6FZLFhvOSN7fp5zLXlrz323yy7uJi4Is23x/8ff/t7fSs6pfOXJAFwM3v/wC6
         b9K7GkitQpHZawyKE3kZzpHbUuUtubBxLFGtKQ2iRJuiB3CI/MtfFoiCW29iMCQ8dHlN
         QW4ksaLmQ68g1benk9nLF3YHPQ85XFEH5RDoUn+xKSZoOZtOcUIY2YJIT/2lrQR9EcJX
         bNwq2XPMP9F+dNHBk8DrarZ3IP1HCvYQ4wsw6VYNZrPGenSK8cfmfLXlkbFLnLqByxJP
         OENBIcoFg7Xni3OlGtxAWkC4nxDOrxtqSZecSg+B09IXvXCPXiIzA7QrmluirCajIzO0
         LhkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v6H5MAo72kBrswxB03BJ2HpgepSBZLZhL5ogd8zupLU=;
        b=VnKSHBRzonKDJnAjrJG+bT+ehxd+xCFN5tu3bOV1svInQYAQrghyfFQJMssYY2yL6i
         co+zOcNsm6QrP6IoANmzve0NgqWIz5H0Wyj7O3CFenoAkOSkPnnptet4CApWNudeMjs9
         srocg20tXGiaU4lgRkgyIWshvq7Mh24sIMe5NEDv8X2Uf9kutsEjVl51itbT1Dl6Jdll
         yWL88r1cA+nEHfq+1uoiwC+4p/99bYAY1R6usOfOidEX1axraPxSr2UZ2/LSpEgrfMtV
         uA8IO+0YuvsyLT1ubTUunohkmjHTNlFyfMTMKYpC9LcjplMEFi9jYM1Gm9v5sXYrU5OX
         AGyw==
X-Gm-Message-State: APjAAAW9wgjQNcvs13tUVwJv0m5l2AokxqSKp4J38fbqTJhlgDHTlTPD
        BYHr9SMYYIZqvSVTgKB9SH18uXZNV38VECK7ASDemA==
X-Google-Smtp-Source: APXvYqx+7FWVD3TK8yBjAqQZMlMkuV+lN5tCxVL10+M37w8cNW4yMIcMcmxP3Kt1PI37oQbyVpTXf/64SZ+48DwdR9o=
X-Received: by 2002:a2e:864e:: with SMTP id i14mr6485594ljj.141.1559321562622;
 Fri, 31 May 2019 09:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <1558648540-14239-1-git-send-email-alan.mikhak@sifive.com>
 <CABEDWGzHkt4p_byEihOAs9g97t450h9-Z0Qu2b2-O1pxCNPX+A@mail.gmail.com>
 <baa68439-f703-a453-34a2-24387bb9112d@ti.com> <CABEDWGyJpfX=DzBgXAGwu29rEwmY3s_P9QPC0eJOJ3KBysRWtA@mail.gmail.com>
 <96365941-512b-dfb2-05b7-0780e8961f6c@ti.com>
In-Reply-To: <96365941-512b-dfb2-05b7-0780e8961f6c@ti.com>
From:   Alan Mikhak <alan.mikhak@sifive.com>
Date:   Fri, 31 May 2019 09:52:31 -0700
Message-ID: <CABEDWGyQHh=8fmZFAK6acecDSF_-pfpa9NCZOQ--WDhZiZPihw@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: endpoint: Skip odd BAR when skipping 64bit BAR
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        lorenzo.pieralisi@arm.com, linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        wen.yang99@zte.com.cn, kjlu@umn.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 9:37 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Hi Alan,
>
> On 25/05/19 12:20 AM, Alan Mikhak wrote:
> > Hi Kishon,
> >
> > Yes. This change is still applicable even when the platform specifies
> > that it only supports 64-bit BARs by setting the bar_fixed_64bit
> > member of epc_features.
> >
> > The issue being fixed is this: If the 'continue' statement is executed
> > within the loop, the loop index 'bar' needs to advanced by two, not
> > one, when the BAR is 64-bit. Otherwise the next loop iteration will be
> > on an odd BAR which doesn't exist.
>
> IIUC you are fixing the case where the BAR is "reserved" (specified in
> epc_features) and is also a 64-bit BAR?

Correct. If BAR0 is specified in epc_features as reserved and also
64-bit, the loop would skip BAR0 by executing the 'continue'
statement. In this scenario, BAR1 doesn't exist since the 64-bit BAR0
spans the two 32-bit BAR0 and BAR1. The loop index 'bar' would be
advanced by 2 in this case so on the next iteration the loop would
process BAR2.

> If 2 consecutive BARs are marked as reserved in reserved_bar of epc_features,
> the result should be the same right?

If both BAR0 and BAR2 are reserved and also 64-bit, the loop would
check BAR0 on its first iteration and skip BAR0 and BAR1, check BAR2
on its second iteration and skip BAR2 and BAR3, then check BAR4 on its
third iteration. If BAR4 is also 64-bit and reserved, the loop would
skip BAR4 and BAR5 and that would be the final iteration of the loop.

Regards,
Alan
