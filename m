Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C145FC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95A6F2070A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 18:55:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CX6pJYGw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbfLBSz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 13:55:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20396 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727936AbfLBSz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 13:55:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575312926;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BasR9fJysMtCMWPHS/Ez/vs7HdvrZKVU0mKfLNeG6GU=;
        b=CX6pJYGwyd5KyH05UMR5BeHCATfsxaUsOgP9iL4y5d22BpNdb4VyZn0e5z+Sn5BI5l1Sh5
        TwGpFOtOTzluivNc+zpDuOCxtTGVlKGNpEqVH7t/yYEOd2kr8ojjaV0koNnyl7z3JrGuam
        Py6GRuUnaBzc9P8tX1ZoosyWlwYk94c=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-4BC4DyDxOzKonpawJrh0aA-1; Mon, 02 Dec 2019 13:55:23 -0500
Received: by mail-pg1-f197.google.com with SMTP id a4so207197pgq.23
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2019 10:55:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3tYGvKckyNK6guzJmLUsGmhSZAtdLju3TCYhP65wmYk=;
        b=VxfMQM5uNf1Ao9xIptJ/O9oiDT/UItU+UPB8vO2JnLW7EK5TVlvC9Fh6Qonk3xSyZS
         9nZMe+DUKnD2KpCK9yFbkDDZWqDL6ytWHcRqc1C4AtV9PxjC8PBXIWNk/tfS3RDokaGw
         UYHbnEgQwzRrhO+xESE87DvigWYodYfGj2pHkRSyI+3srppHbyc5xSmCYj4WdcrBQorm
         OA0Scjd/T1Jlqq/zgukZHeoG0rng2Tigr19NaMmXCU6Q9+4S7kGXtbB9G7oFqdshq3PS
         4MlLSTYtdzahItKSe2D2zhZn/Fvil4+nqbEwgtufBBTEiIcGNKBYw1YvEC40HZ5K9bsb
         5XwQ==
X-Gm-Message-State: APjAAAXiW+T6nOMYXKXEBCaYIqIANmUIwpGc3sXCAOvhcQ6k/Aj3fEeK
        cjw11L9p0kb2EQ6+r1UEJLiZCcsMUSyezFbYuW53Ycn1qBjIuxmYP1y63NIs7HX3y2y14jU1ilI
        gSTuAR44Hy94+MJ9CLq45w5hj
X-Received: by 2002:a17:902:9a49:: with SMTP id x9mr631793plv.331.1575312922277;
        Mon, 02 Dec 2019 10:55:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqx10URV1PHP5Yt2PPgF5JNaFQDDTv65xxiVu8l3E0jlcc9g5YQ3pGK9NLzlsY1cV2dHkq7eDg==
X-Received: by 2002:a17:902:9a49:: with SMTP id x9mr631768plv.331.1575312921957;
        Mon, 02 Dec 2019 10:55:21 -0800 (PST)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id d85sm203111pfd.146.2019.12.02.10.55.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2019 10:55:21 -0800 (PST)
Date:   Mon, 2 Dec 2019 11:55:20 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Stefan Berger <stefanb@linux.ibm.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 0/2] Revert patches fixing probing of interrupts
Message-ID: <20191202185520.57w2h3dgs5q7lhob@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20191126131753.3424363-1-stefanb@linux.vnet.ibm.com>
 <20191129223418.GA15726@linux.intel.com>
 <6f6f60a2-3b55-e76d-c11a-4677fcb72c16@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <6f6f60a2-3b55-e76d-c11a-4677fcb72c16@linux.ibm.com>
X-MC-Unique: 4BC4DyDxOzKonpawJrh0aA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Dec 01 19, Stefan Berger wrote:
>On 11/29/19 5:37 PM, Jarkko Sakkinen wrote:
>>On Tue, Nov 26, 2019 at 08:17:51AM -0500, Stefan Berger wrote:
>>>From: Stefan Berger <stefanb@linux.ibm.com>
>>>
>>>Revert the patches that were fixing the probing of interrupts due
>>>to reports of interrupt stroms on some systems
>>Can you explain how reverting is going to fix the issue?
>
>
>The reverts fix 'the interrupt storm issue' that they are causing on=20
>some systems but don't fix the issue with the interrupt mode not being=20
>used. I was hoping Jerry would get access to a system faster but this=20
>didn't seem to be the case. So sending these patches seemed the better=20
>solution than leaving 5.4.x with the problem but going back to when it=20
>worked 'better.'
>

I finally heard back from IT support, and unfortunately they don't
have any T490s systems to give out on temp loan. So I can only send
patched kernels to the end user that had the problem.

>
>>
>>This is wrong way to move forward. The root cause must be identified
>>first and then decide actions like always in any situation.
>>
>>/Jarkko
>
>

