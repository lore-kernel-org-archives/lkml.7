Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D412FC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D9832173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 15:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Rjenc5zT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403944AbfHHPuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 11:50:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:40259 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403889AbfHHPuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 11:50:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id l15so63230694oth.7
        for <linux-kernel@vger.kernel.org>; Thu, 08 Aug 2019 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=V04LJKvCA0wB/HmsqcSMs/4DuagqVihnyf8uqYLL87Q=;
        b=Rjenc5zTLUajzfiBedUaxjBiG1dhLJKjDLzS3UjIrusjrHXpf7CCE15NIbWxBhf6x2
         nvKbbMmWa6RH+y0ZDTTvg77tQLFGuhNysOD/LNi+gRJHzyNfnmCeNRAC2GBGNBYKwvkH
         5N8d26wze5KVYPDse72CjDU+ghlwcRp/l3VqNvx8ZGbaguxCbhKbpJiSp+K6FxJfgK7b
         SS/Fmvv8cDGxJyPEpHHTFTiuMIN3L1jaiNnLDgxkeZqxMJwaAMJwkjUNBjVJteC5wA7P
         LOqEzIFkuLAGC4F76tEqKI36IIfGJyTatKKeo17l0bIREcogBFOTbbhDG5gbK1LVQi9o
         ANYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=V04LJKvCA0wB/HmsqcSMs/4DuagqVihnyf8uqYLL87Q=;
        b=OdvStiAA3cvPFiTFoDppfLxCRBDQM4opwTJ33BmzoqkteRq0N9sPmTSykzsD3O+4hG
         57YmcTNWSTiWR/d1WWQ2oBlJs1WjWfMRJ2QFRsL/X7AjLLsszyLx0y+pp+CNKSXvez8C
         X13k+77gJrIFQXQOKyR7L/cKsJ+rA/lo56AM2Lgly4M8a/qCn8Qzo7SBrLXaDjgzF1re
         H8cBZh39DDXKHB1QR8u2hBBjcQR3K4X6Mh+tu0wBL3UYy/XdZLZtgJlp2GQs0ft3tWBI
         P2OROJGhbpMgIbsMdsCaV2OpdK+nRCRov5/qMuAEWDgIoNa5tXfCTUloUUXPeOODlI20
         7tAg==
X-Gm-Message-State: APjAAAU1x2lFVjQeObFph6FUNSdPz41amFplPMOqI6BvlAlYrL6SeazA
        2m8l+rDofSRKXIFvQB3SVgfW9A==
X-Google-Smtp-Source: APXvYqxcQzfpDuRczKMtOS49c3Tn97t1k3O5DW8Qp2eNDaFvhOHqa22tgIBfww5r1gp0e8ooLoY7ZA==
X-Received: by 2002:a6b:6409:: with SMTP id t9mr4933342iog.270.1565279411935;
        Thu, 08 Aug 2019 08:50:11 -0700 (PDT)
Received: from localhost (c-73-95-159-87.hsd1.co.comcast.net. [73.95.159.87])
        by smtp.gmail.com with ESMTPSA id h18sm73180520iob.80.2019.08.08.08.50.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 08 Aug 2019 08:50:09 -0700 (PDT)
Date:   Thu, 8 Aug 2019 08:50:09 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <anup@brainfault.org>
cc:     Vincent Chen <vincent.chen@sifive.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] riscv: Correct the initialized flow of FP register
In-Reply-To: <CAAhSdy0BNN4G270WJ+OqrFAv3-z9o2iE+QDHHo-FY0fqh5wGqg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.9999.1908080846220.21111@viisi.sifive.com>
References: <1565251121-28490-1-git-send-email-vincent.chen@sifive.com> <1565251121-28490-2-git-send-email-vincent.chen@sifive.com> <CAAhSdy0BNN4G270WJ+OqrFAv3-z9o2iE+QDHHo-FY0fqh5wGqg@mail.gmail.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 8 Aug 2019, Anup Patel wrote:

> On Thu, Aug 8, 2019 at 1:30 PM Vincent Chen <vincent.chen@sifive.com> wrote:
> >
> > +static inline void fstate_off(struct task_struct *task,
> > +                              struct pt_regs *regs)
> > +{
> > +       regs->sstatus = (regs->sstatus & ~(SR_FS)) | SR_FS_OFF;
> 
> The SR_FS_OFF is 0x0 so no need for ORing it.

That one looks OK to me, since it makes it more obvious to humans what's 
happening here - reviewers won't need to know that "off" is 0x0.  The 
compiler should drop it internally, so it won't affect the generated 
code.

> Apart from above minor comment, looks good to me.
> 
> Reviewed-by: Anup Patel <anup@brainfault.org>

Will add your Reviewed-by: tag - let us know if you want me to drop it or 
caveat it.


- Paul
