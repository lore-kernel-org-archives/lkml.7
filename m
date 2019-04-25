Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2A0C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F81C20717
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 23:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="ABdGz3Zs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="YXAzZlg5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbfDYXTF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 19:19:05 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56712 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbfDYXTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 19:19:05 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id B78D88EE128;
        Thu, 25 Apr 2019 16:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556234342;
        bh=fMxWW2XE8pJ3bJdRRHAaQs1JoNnXt48P1mEGYbiDo9s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ABdGz3ZshXma0aCBC9ltamj6CDJob0Nmf3SgYLhXzfln2Kkv0X3XN9yp38y+ynK2v
         BhOYfukRKIprcRD/7+L6dmoxpH9FTUPig+UKFrjqXcwwKcQGd9WF18L9Vv55Jm9XSv
         MAKuO14E+JZeRa2GfNIUCyJSDSi8OkxEfMdU/D58=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bnOL8x0gA6Fv; Thu, 25 Apr 2019 16:19:01 -0700 (PDT)
Received: from [153.66.254.194] (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id EF2CB8EE0AB;
        Thu, 25 Apr 2019 16:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1556234340;
        bh=fMxWW2XE8pJ3bJdRRHAaQs1JoNnXt48P1mEGYbiDo9s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=YXAzZlg55SJpB/+onn2s9I2iXx3YwcLNN53U9BvpaQGvX8DrWwxcl+fpVfHWUN48I
         BCVIo409pYRU5G3jbv/LKmMvjuE5flMrJJRf5dO4dQxV6SlWYcR98/bCqxFValwNiN
         t6JL2S3Vjo/Bqnc5wSZgcLnf8wcxWZNlGRVcwChQ=
Message-ID: <1556234338.2788.1.camel@HansenPartnership.com>
Subject: Re: [PATCH v2 2/5 RFC] use event name instead of enum to make the
 call generic
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     James Morris <jmorris@namei.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     prsriva <prsriva@linux.microsoft.com>,
        Nayna <nayna@linux.vnet.ibm.com>,
        Prakhar Srivastava <prsriva02@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        inux-security-module@vger.kernel.org, zohar@linux.ibm.com,
        "Eric W. Biederman" <ebiederm@xmission.com>, vgoyal@redhat.com,
        Prakhar Srivastava <prsriva@microsoft.com>
Date:   Thu, 25 Apr 2019 16:18:58 -0700
In-Reply-To: <alpine.LRH.2.21.1904260833140.7315@namei.org>
References: <20190424001544.7188-1-prsriva02@gmail.com>
         <20190424001544.7188-2-prsriva02@gmail.com>
         <d38f32f8-7078-f205-ba11-9c4266ee40e8@linux.vnet.ibm.com>
         <4c313367-22dc-9532-54b5-cd3a79deb625@linux.microsoft.com>
         <CAADWXX8NC-PFJmuvQbNXn49CYjvyn-e0rtH_EoUfCvuJHTwHAQ@mail.gmail.com>
         <alpine.LRH.2.21.1904260833140.7315@namei.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-04-26 at 08:34 +1000, James Morris wrote:
> On Thu, 25 Apr 2019, Linus Torvalds wrote:
> 
> > On Thu, Apr 25, 2019 at 10:19 AM prsriva <prsriva@linux.microsoft.c
> > om> wrote:
> > > 
> > > I will fix the comments and send out the patchset with a cover
> > > letter. Thankyou for pointing this out.
> > 
> > Please trim the emails you reply to rather than quoting everything.
> > 
> > But the real reason I'm reacting to this email is because it was
> > marked as spam, because your SMTP setup is incorrect, and you don't
> > go through the proper MS SMTP server. As a result, you don't get
> > the proper DKIM signature for verification of the microsoft.com
> > email address, and sane email clients will mark your emails as
> > spam.
> > 
> > Please fix.
> 
> It's the correct SMTP server for linux.microsoft.com.
> 
> linux.microsoft.com.	3600	IN	TXT	"v=spf1
> ip4:13.77.154.182 -all"
> linux.microsoft.com.	3600	IN	TXT	"v=DMARC
> 1;p=none;pct=100;rua=mailto:jamorris@microsoft.com"

That's not the correct location: DMARC records should be at the _dmarc.
subdomain.  without this you'll inherit the dmarc policy of
_dmarc.microsoft.com

> We don't have DKIM set up yet.

If you advertise DMARC, you're expected to have DKIM working for spam
purposes.  On the other hand, if you don't advertise DMARC, google will
probably still bin all your email as spam.

James

