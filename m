Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1A2C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E180E21848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 08:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="jYd0dyQA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732553AbfIEIVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 04:21:21 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:27548 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbfIEIVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 04:21:20 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id BA39840D2F;
        Thu,  5 Sep 2019 10:21:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1567671678; x=1569486079; bh=4Z50Q95LKCLv+niIV0/5wFqe396UpDg1Zkb
        3D4r9NEA=; b=jYd0dyQAgqo6U3IFELUCjZ+bPOba6sveH6McsrhqmHTnxKrp7oZ
        QqdJpMwTgwuxpjiwPrws7YdMtsygpLWqqP5y8wPu3pkMykrV4UXTlaEh44iDUVxI
        z/uXQzOZxvjU1l/iw7/xC75qzg5TS9ti8OLdZ5a23CO62NmxxWANg22eJa57NvBX
        ngW9aPCxX0kBJm1URP95kJbGzfdpEdgI2OvVWWHBrIvuIA7uKn4cyWFBbGo0w3k9
        bionnw6bi0G4wrjuyWZfLC/1pCecNKeBQmjB2aLwTJ7oRiW0XObOx9JW4ttYeOvN
        1IUbFFpzGFsI/Ov/DeeMsRX+hH8vyTQEYVAQiGSMVRFSlco0gtfLSulrlDNCZbs6
        2vr+RkHoucBPTJNBq+epdArmODOMwi7fRvQePQb4EmXPE1SQfOT6TxSPvZHQYVs+
        eZZXvKche96IIIBBTMwC8bwa+z6D7kEVShhcgG/fsW4F7aFLITeejLNnrzb9LyFk
        W4n4mnulGLSik5UZhG1QMGP7bUWpcH6phIw/UGxHNOWA2qs/qcka4MtV2GLg38pX
        90J07dRYBPHg6ICzz6jTzmjbogQfhKf24GI+o/GWIq3WGrLDmfsMw2iMa34pzCv9
        Eca8cZ9gCHloRbZwCcfEL/RPtt3fuFElvLgPNFwEtKxcF7Q5Ob9X/jjU=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xVVOF3E9Fb-H; Thu,  5 Sep 2019 10:21:18 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 3DC6F40D26;
        Thu,  5 Sep 2019 10:21:18 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id C173951F9;
        Thu,  5 Sep 2019 10:21:17 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc:lock: remove reference to clever use of read-write lock
Date:   Thu, 05 Sep 2019 10:21:16 +0200
Message-ID: <261280816.8eN5xxrYeQ@harkonnen>
In-Reply-To: <20190831084344.6fd7c039@lwn.net>
References: <20190831134116.25417-1-federico.vaga@vaga.pv.it> <20190831084344.6fd7c039@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, August 31, 2019 4:43:44 PM CEST Jonathan Corbet wrote:
> On Sat, 31 Aug 2019 15:41:16 +0200
> 
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> >  several CPU's and you want to use spinlocks you can potentially use
> > 
> > -cheaper versions of the spinlocks. IFF you know that the spinlocks are
> > +cheaper versions of the spinlocks. If you know that the spinlocks are
> > 
> >  never used in interrupt handlers, you can use the non-irq versions::
> I suspect that was not actually a typo; "iff" is a way for the
> mathematically inclined to say "if and only if".

Unfortunately this thread focused on this little thing ^_^'

What about the patch itself? Should I send a new one without this fix or you 
will apply it as it is?






