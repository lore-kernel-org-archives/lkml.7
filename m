Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0113AC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C810120665
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 21:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="SHDFc2Y1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="PGHaR61M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727216AbfLPVRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 16:17:14 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35592 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726646AbfLPVRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 16:17:14 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id EE2138EE162;
        Mon, 16 Dec 2019 13:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576531032;
        bh=qDwPI2g9+7L4Q17BKbe37Z39nActyjGzJ1fRbliFvwM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SHDFc2Y1lAfSXF5o4oIbw4jDoYoibZSfpEJ/NL+6hQDbvCLrJ9rgYOQeSuZluTQq5
         YnhT7lHpBKCwgmR5es/y44v6CfROrDegM/JDgR9ztMTcT1oq+YR5pGXGnmsPq53BGo
         ppDXuS4MLsM7ZLcyitD8UGZEWN+9b+i32tGCsZkg=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id F0ANl-k-lWju; Mon, 16 Dec 2019 13:17:11 -0800 (PST)
Received: from [172.20.4.137] (122x212x32x58.ap122.ftth.ucom.ne.jp [122.212.32.58])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 4C6B68EE111;
        Mon, 16 Dec 2019 13:17:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576531031;
        bh=qDwPI2g9+7L4Q17BKbe37Z39nActyjGzJ1fRbliFvwM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PGHaR61MngifKP/wX56vU3TNm7g+W2d1l31JCDjzRrXKhPJi27Y62AdJSc42uyNwJ
         b1qEOboJ3y7opz5VnABqfDN91GednZdrCC/jTh15zVblqTD29EEONn77DhhMPTIrC5
         RBryNRdDdm4weq8tHDX0fGWqFCCBcOfOLiHw2grU=
Message-ID: <1576531022.3365.6.camel@HansenPartnership.com>
Subject: Re: [PATCH v4 2/2] IMA: Call workqueue functions to measure queued
 keys
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, linux-integrity@vger.kernel.org
Cc:     eric.snowberg@oracle.com, dhowells@redhat.com,
        mathew.j.martineau@linux.intel.com, matthewgarrett@google.com,
        sashal@kernel.org, jamorris@linux.microsoft.com,
        linux-kernel@vger.kernel.org, keyrings@vger.kernel.org
Date:   Tue, 17 Dec 2019 06:17:02 +0900
In-Reply-To: <8844a360-6d1e-1435-db7c-fd7739487168@linux.microsoft.com>
References: <20191213171827.28657-1-nramas@linux.microsoft.com>
         <20191213171827.28657-3-nramas@linux.microsoft.com>
         <1576257955.8504.20.camel@HansenPartnership.com>
         <39624b97-245c-ed05-27c5-588787aacc00@linux.microsoft.com>
         <1576423353.3343.3.camel@HansenPartnership.com>
         <1568ff14-316f-f2c4-84d4-7ca4c0a1936a@linux.microsoft.com>
         <1576479187.3784.1.camel@HansenPartnership.com>
         <8844a360-6d1e-1435-db7c-fd7739487168@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-12-16 at 11:20 -0800, Lakshmi Ramasubramanian wrote:
>   => If the flag is false, mutex is taken and the flag is checked
> again. If the flag changed from false to true between the above two
> tests, that means another thread had raced to call
> ima_process_queued_keys() and has  processed the queued keys. So
> again, no further action is required.

This is the problem: in the race case you may still be adding keys to
the queue after the other thread has processed it. Those keys won't get
processed because the flag is now false in the post check so the
current thread won't process them either.

James

