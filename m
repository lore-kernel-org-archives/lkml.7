Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DBBAC43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 21:25:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EC6721743
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 21:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sl0AarRP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfD3VZE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 17:25:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35862 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfD3VZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 17:25:03 -0400
Received: by mail-pl1-f196.google.com with SMTP id w20so6707051plq.3;
        Tue, 30 Apr 2019 14:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zw93kVo3Zfkf7gA3YeXj6RSgg5k0vIjqnM2DvtbZHAI=;
        b=sl0AarRP1TsvqN4lIwtjAb0B7biXJtnSNV8bx8FXEYhSEVymQc0Bxt+S0pI62T/gGo
         UrlqSLPeDYFLsnniqZnzOvn8n9Mns2rYJshQy8w3iWdy1LDPahYAKDHNJVTkZpDMhWTG
         Yn2cSsbdygxsKI4OzWXA0V58tU3zeE4oUTiPenk+x8wD0+dAy7PhWBuC/Eh7TSvUnMdu
         pgd1yT7EXyORAAh0hdDdesfLe2EhRT1+rwQ4iyJnXehq3RNXyyiy+kjNy8QYsGeAhkz1
         TjHdKzY0q1Xtn1NAtFgyktwrDYG5RQozIBXE7po/5MQx3ShjVvEZkJj2SZOCwwwEfit+
         S8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zw93kVo3Zfkf7gA3YeXj6RSgg5k0vIjqnM2DvtbZHAI=;
        b=ckD3PEqG7LBDVwo+53uBdrUbHuvrBpBZKHxJwSP26GhUFy3REXmdarxSmF1X507/oz
         ZAIJkCyBVhA/yP8S9yE3pUjHAg5TYlmocqFjBmwLlja/B7XDpGGBWPJZwPXPojKDbB2F
         dUe0oetqDDOSmd77j/0lZCeaofMVuDZWQRfaFjOyBBS2s+DuWDOwtGb4YQT+R3CKhL+/
         YMRadYJN6TL5LcrtwTR8rakZWjBtkYPzBOpMzN9DMTRDhNh2ZfEk4/tYVb1OLClXLpI4
         GWvncxh30Ugc0GGQskEmXNbrcQIUCQjPGl26KBxrTeuZ29kqGoBFp+NJ43G+q+DDaVUf
         if6A==
X-Gm-Message-State: APjAAAVmocpvt/OG/kuE7fMU5GtlCW2VG5eW6kzQz+I1dBmpnaeJqzbF
        SQWLRAsK9KQ549gujz5X7F6yrhyHwOQWHE03Lsk8LFYj
X-Google-Smtp-Source: APXvYqxPDZtFpO+c7rNvc+k762smiJY4RzJneujKOPsKuF9emm+FzXjVhnEMgIQjRUzdONAxVuppQ5NJ4a2hctrRhOA=
X-Received: by 2002:a17:902:9b8d:: with SMTP id y13mr17753012plp.70.1556659502588;
 Tue, 30 Apr 2019 14:25:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190429173805.4455-1-mcroce@redhat.com>
In-Reply-To: <20190429173805.4455-1-mcroce@redhat.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Tue, 30 Apr 2019 14:24:51 -0700
Message-ID: <CAM_iQpXB83o+Nnbef8-h_8cg6rTVZn194uZvP1-VKPcJ+xMEjA@mail.gmail.com>
Subject: Re: [PATCH net] cls_matchall: avoid panic when receiving a packet
 before filter set
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Jiri Pirko <jiri@resnulli.us>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 29, 2019 at 10:38 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> When a matchall classifier is added, there is a small time interval in
> which tp->root is NULL. If we receive a packet in this small time slice
> a NULL pointer dereference will happen, leading to a kernel panic:

Hmm, why not just check tp->root against NULL in mall_classify()?

Also, which is the offending commit here? Please add a Fixes: tag.

Thanks.
