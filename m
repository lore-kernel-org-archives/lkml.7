Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AA9C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC9B2243E
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 10:35:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxG0AtBW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbfKTKfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 05:35:48 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48738 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727697AbfKTKfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 05:35:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574246146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/xDM99yDTDLv4Ym8i8Vqr3jGmgK95cfJTK+1ci9q0Y=;
        b=YxG0AtBW1cKya20byz+qIZX111jy93qPDlm5CffVTOs0/i9mI4YIPm1gU2bCQNT69G4/am
        /d1VpdqmyKgXL3iW4w40oztGVG5RVXA5qbS1GT3peSwI+x4Iy6wGEFJcbp+VCiKEjSXjhU
        M9yMqxtqlLKOz3J5vgd7dcciRHQI0mQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-2pPJKldfNQapjGbh34vBPQ-1; Wed, 20 Nov 2019 05:35:43 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 14BCA477;
        Wed, 20 Nov 2019 10:35:41 +0000 (UTC)
Received: from [10.36.118.126] (unknown [10.36.118.126])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B71019EE6;
        Wed, 20 Nov 2019 10:35:37 +0000 (UTC)
Subject: Re: [PATCH v1 01/12] powerpc/pseries: CMM: Implement release()
 function for sysfs device
To:     Michael Ellerman <patch-notifications@ellerman.id.au>,
        linux-kernel@vger.kernel.org
Cc:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, Paul Mackerras <paulus@samba.org>,
        Allison Randal <allison@lohutok.net>,
        Arun KS <arunks@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Vlastimil Babka <vbabka@suse.cz>
References: <47DFy90198z9sSZ@ozlabs.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <23fed8a4-d87a-c6f6-e145-715eceea4e64@redhat.com>
Date:   Wed, 20 Nov 2019 11:35:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <47DFy90198z9sSZ@ozlabs.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2pPJKldfNQapjGbh34vBPQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.11.19 10:08, Michael Ellerman wrote:
> On Thu, 2019-10-31 at 14:29:22 UTC, David Hildenbrand wrote:
>> When unloading the module, one gets
>> [  548.188594] ------------[ cut here ]------------
>> [  548.188596] Device 'cmm0' does not have a release() function, it is b=
rok=3D
>> en and must be fixed. See Documentation/kobject.txt.
>> [  548.188622] WARNING: CPU: 0 PID: 19308 at drivers/base/core.c:1244 .d=
evi=3D
>> ce_release+0xcc/0xf0
>> ...
>>
>> We only have on static fake device. There is nothing to do when
>> releasing the device (via cmm_exit).
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
>> Cc: Allison Randal <allison@lohutok.net>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Arun KS <arunks@codeaurora.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>=20
> Patches 1-10 applied to powerpc next, thanks.
>=20
> https://git.kernel.org/powerpc/c/7d8212747435c534c8d564fbef4541a463c976ff
>=20
> cheers
>=20

Hi Michael,

just to make sure you saw the two MM patches (and the ACKs from Michal)

https://lkml.org/lkml/2019/11/14/410

if you prefer that Andrew picks these up, please let me know.

Cheers!

--=20

Thanks,

David / dhildenb

