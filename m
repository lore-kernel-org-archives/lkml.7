Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E21C43218
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:19:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221F120717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556234391;
	bh=oy9mkRIJ27E/78TIf184RjzExaYF8UiQ3DFQaz1wM3M=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Z83XTn53blTrFMtUMq7hnm1FFolCzrJui9zAuHGiVwNbqc1dLxIcaZtT/qoHaEb1+
	 4gRBXCwYsnmcpWI/6HM1mRwd/9qJ8Xbcs59toCufHHZVdTid5IqtwH4e+CF4KCn2KD
	 Du4ptMmE9eQVx4AW++rCTIh2cIZgqBPjOIQVyD3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfDYXTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:19:49 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46847 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfDYXTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:19:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id h21so1124719ljk.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 16:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JVMMh5fN5ozrCrHID7oOuvIh5XNOIIl8KqXF7UDwSbM=;
        b=FdPlTG3RMyWGkT/hrEbJE6gWCmVVUw7blvL5J103CSzw5P7J1SZbN9GFwIMe8kzQ0Q
         443a6k4EK2MynrpRPzqVtPdx6RbGXzw8RIJTZPE+8McLQadG2TpJtdtYmzcCC3EtG3PM
         anXQwKgWPv6ogPlKDoh5kmY/zn33Sen4u3fuk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JVMMh5fN5ozrCrHID7oOuvIh5XNOIIl8KqXF7UDwSbM=;
        b=ljGKE6v5eyjR2fnGjC7cKgvBSqqQG58NSX0vR5wzWJAELxddavI20YSrDi2AmbryV2
         U8sNtxmn78MLyn0/6Adlcjyac8wFl1in3/ZIOV+7b2fR27k4ypUj8+kv3iWo/O/LoHOf
         2h1V2ljR/yMpQLZlWjs2oMwBs5K+Su9ghMWO9Xfyh/Mqo/CXNhp4d8VGlkgbAM3bmJRo
         Z+vWd8yV3EohLPSa3IGtkKY+Rcu9MtQg8u7fWi8m2YQ6DLxzNXkC0hV1vNFqeyEYDzAf
         MC5mxX9aTnD+sbGbD9SfQkPAD1SGdgh+k+gM+CqLrlP201BseiK/f9pUn/cCN3REjt0I
         cA/A==
X-Gm-Message-State: APjAAAVaQQyH/f+N22k9HCyTbLe+UN9KcCYjBksrtfxNiGSgurIPIIzm
        nIqsU/vygoME3v7a9+b+YgymxFR3+Q8=
X-Google-Smtp-Source: APXvYqwYJ6lwpi1TohvysqL7GhENJCY4F478tf0Z2kzwCCK/PA0osPiNlXI0c7ifYJEdrZNu04c45g==
X-Received: by 2002:a2e:81d0:: with SMTP id s16mr23059142ljg.182.1556234386687;
        Thu, 25 Apr 2019 16:19:46 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id g10sm5161195lfb.85.2019.04.25.16.19.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 16:19:45 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id d12so1038942lfk.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 16:19:45 -0700 (PDT)
X-Received: by 2002:a19:f50e:: with SMTP id j14mr21325408lfb.11.1556234385341;
 Thu, 25 Apr 2019 16:19:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190424001544.7188-1-prsriva02@gmail.com> <20190424001544.7188-2-prsriva02@gmail.com>
 <d38f32f8-7078-f205-ba11-9c4266ee40e8@linux.vnet.ibm.com> <4c313367-22dc-9532-54b5-cd3a79deb625@linux.microsoft.com>
 <CAADWXX8NC-PFJmuvQbNXn49CYjvyn-e0rtH_EoUfCvuJHTwHAQ@mail.gmail.com> <alpine.LRH.2.21.1904260833140.7315@namei.org>
In-Reply-To: <alpine.LRH.2.21.1904260833140.7315@namei.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Apr 2019 16:19:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4RdXiy4JTPJ5tcFAsjQe1a9+C9_35Y0m6wrjY8nQVgw@mail.gmail.com>
Message-ID: <CAHk-=wg4RdXiy4JTPJ5tcFAsjQe1a9+C9_35Y0m6wrjY8nQVgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/5 RFC] use event name instead of enum to make the
 call generic
To:     James Morris <jmorris@namei.org>
Cc:     prsriva <prsriva@linux.microsoft.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 3:34 PM James Morris <jmorris@namei.org> wrote:
> >
> > Please fix.
>
> It's the correct SMTP server for linux.microsoft.com.

In that case, it seems that your SMTP server is misconfigured, and
shouldn't be used.

> linux.microsoft.com.    3600    IN      TXT     "v=spf1 ip4:13.77.154.182 -all"
> linux.microsoft.com.    3600    IN      TXT     "v=DMARC1;p=none;pct=100;rua=mailto:jamorris@microsoft.com"
>
> We don't have DKIM set up yet.

I get

       dmarc=fail (p=REJECT sp=REJECT dis=QUARANTINE) header.from=microsoft.com

because the microsoft.com DMARC rules will be triggered before the
"linux.microsoft.com" rules are.

                   Linus
