Return-Path: <SRS0=try7=ZI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCB9C43215
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 00:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09CC420730
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Nov 2019 00:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bzwXzcLi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKPAMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 19:12:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31959 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727183AbfKPAMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 19:12:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573863141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YucaLxiSa+lbBdWZEiOMixRcsCv7ML3d3r0Ac+pjQcY=;
        b=bzwXzcLij/PLQ/XEbggwW3DKDYl+dFkc2EoOD0AWGDUuY7xpGB97XX9bAfQsPc0enIoS4S
        oF2zwOKXFEdwlx0YhIQk/a1Mb7hr2kkW6pAUMNFwqIcfb59jHSeanrV1hXaHZWJFGq4aXd
        6rlCxE5pnAQs2faJ+989NSSia7gaYQM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-a0MZMA09P_WGItiTfoaftQ-1; Fri, 15 Nov 2019 19:12:20 -0500
Received: by mail-wr1-f71.google.com with SMTP id p6so9326161wrs.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2019 16:12:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=XgPDDVC4pj4uBAGw7ABCh7Q7KCQNqcWlZruL9lBUGm4=;
        b=enIDLZF8HZ1bnpfLnirKNPMbpNu0uLOPbnonNpkZNwy7tSasD9nMIgW9aAO2WfbXmI
         icUuZixe8KHprXPCGOqjDz+JufvKO4RVu1aETWVeh19sDdKUa2g7vXsYcxzhxD28wR0l
         PT8Q2LdxH1o2G3E1zxXpxXowhBJdmkS+dDkfGvPSnc1y+MIE//Hrf4jk9bd8Wr1teU1b
         AbCfzVb9Ap7Vf8aWV1Ar8l8ngBNk/Ew3dVgjVBfi1H73Ehwdw+cLcLFZJUM7M8fWZ5Sw
         wld0oolKB8LTePskBEr7EErME3+nVU+Q9/2cDpvDLkyTN1UR0UAcVqV28M2YXb9lkWpA
         MNgA==
X-Gm-Message-State: APjAAAXYo8mF4iKXIjBqHTIVeu/4zMlMgeKH4K7hd3l9Sm3kbNPU/zqB
        +loDpDWT3HnyQtISSrHUtv81FGopvd4xci6WByZ0UVE1z3oaxuWUbnCfNeaExAbD9rMd/UnM4EY
        TdcvAgJGm1LUw7IkO5bY0dper
X-Received: by 2002:adf:e312:: with SMTP id b18mr4650614wrj.203.1573863138983;
        Fri, 15 Nov 2019 16:12:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqzuVcbtdtlvJftih7/AXWTYumzxtiDyUUaIJ6IUYkm08DAAbDt3jr5OSJ1vjIQacxYbq6hTSg==
X-Received: by 2002:adf:e312:: with SMTP id b18mr4650602wrj.203.1573863138778;
        Fri, 15 Nov 2019 16:12:18 -0800 (PST)
Received: from [192.168.3.122] (p4FF23E4C.dip0.t-ipconnect.de. [79.242.62.76])
        by smtp.gmail.com with ESMTPSA id f13sm12841564wrq.96.2019.11.15.16.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Nov 2019 16:12:18 -0800 (PST)
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] mm/memory_hotplug: Fix try_offline_node()
Date:   Sat, 16 Nov 2019 01:12:16 +0100
Message-Id: <E2EAC147-4F23-4B12-9C80-42FE28F03D26@redhat.com>
References: <20191115160833.beda52bc6f1145bc81960ba7@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Tang Chen <tangchen@cn.fujitsu.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Keith Busch <keith.busch@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
In-Reply-To: <20191115160833.beda52bc6f1145bc81960ba7@linux-foundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
X-Mailer: iPhone Mail (17A878)
X-MC-Unique: a0MZMA09P_WGItiTfoaftQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Am 16.11.2019 um 01:08 schrieb Andrew Morton <akpm@linux-foundation.org>:
>=20
> =EF=BB=BFOn Thu, 7 Nov 2019 19:58:45 -0800 Andrew Morton <akpm@linux-foun=
dation.org> wrote:
>=20
>> On Thu, 7 Nov 2019 00:14:13 +0100 David Hildenbrand <david@redhat.com> w=
rote:
>>=20
>>>> +    /*
>>>> +     * Especially offline memory blocks might not be spanned by the
>>>> +     * node. They will get spanned by the node once they get onlined.
>>>> +     * However, they link to the node in sysfs and can get onlined la=
ter.
>>>> +     */
>>>> +    rc =3D for_each_memory_block(&nid, check_no_memblock_for_node_cb)=
;
>>>> +    if (rc)
>>>>          return;
>>>> -    }
>>>>=20
>>>>      if (check_cpu_on_node(pgdat))
>>>>          return;
>>>>=20
>>>=20
>>> @Andrew, can you queued this one instead of v1 so we can give this some=
=20
>>> more testing? Thanks!
>>=20
>> Sure.
>>=20
>> We have a tested-by but no reviewed-by or acked-by :(
>>=20
>> Null pointer derefs are unpopular.  Should we cc:stable?
>=20
> <Crickets>
>=20
> I added cc:stable and shall send it upstream unreviewed.

Yes, please cc:stable at as mentioned in the patch comments (below the desc=
ription). Maybe we=E2=80=98ll find somebody last minute to review ... thank=
s!

>=20

