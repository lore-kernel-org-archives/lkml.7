Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 161A9C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02062464D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 09:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dDwKcV9Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbfLEJhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 04:37:36 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:60064 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726096AbfLEJhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 04:37:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575538654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RgTZ0Y2VUw+Z4N1mKD1L2XaEnRTLuyDRai6jz97PnGk=;
        b=dDwKcV9Zx3Q5mEMc/LDYJ7bNkNwSmR52byGkqbjaxpmOoRBHuFrQL8Rn2ioJfo1pmPoSnh
        hJvyAOtkuJX/dUpnggM9AqOt8ti4+BhOQPJ4Q46/SLCKL7Ry8MTG1Coo8/BU+A6S1tocQv
        +mNQtbJJk/j5vpiaoo1fQG8sZgdibmA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-4ieccuSzO8GpALfjAN5pKg-1; Thu, 05 Dec 2019 04:37:29 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 571BF800D5A;
        Thu,  5 Dec 2019 09:37:28 +0000 (UTC)
Received: from [10.36.116.117] (ovpn-116-117.ams2.redhat.com [10.36.116.117])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D78A76E702;
        Thu,  5 Dec 2019 09:37:25 +0000 (UTC)
Subject: Re: [RFC 3/3] KVM: arm64: pmu: Enforce PMEVTYPER evtCount size
To:     Will Deacon <will@kernel.org>
Cc:     eric.auger.pro@gmail.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        james.morse@arm.com, andrew.murray@arm.com, suzuki.poulose@arm.com,
        drjones@redhat.com
References: <20191204204426.9628-1-eric.auger@redhat.com>
 <20191204204426.9628-4-eric.auger@redhat.com>
 <20191205090232.GC8606@willie-the-truck>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <c1a876be-49ab-0b5f-8ddd-1a47bcf89300@redhat.com>
Date:   Thu, 5 Dec 2019 10:37:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191205090232.GC8606@willie-the-truck>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 4ieccuSzO8GpALfjAN5pKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On 12/5/19 10:02 AM, Will Deacon wrote:
> On Wed, Dec 04, 2019 at 09:44:26PM +0100, Eric Auger wrote:
>> ARMv8.1-PMU supports 16-bit evtCount whereas 8.0 only supports
>> 10 bits.
>>
>> On Seatlle which has an 8.0 PMU implementation, evtCount[15:10]
>> are not read as 0, as expected. Fix that by applying a mask on
>> the selected event that depends on the PMU version.
> 
> Are you sure about that? These bits are RES0 in 8.0 afaict, so this would be
> a CPU erratum. Have you checked the SDEN document (I haven't)?

You're right. It is RES0 and not RAZ. My mistake. Please ignore this patch.

Thank you for the feedback.

Eric
> 
> Will
> 

