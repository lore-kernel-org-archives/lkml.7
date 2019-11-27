Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BDE4C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBACD20866
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 19:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Wf5h3r66"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbfK0ThM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:37:12 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45518 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfK0ThL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 14:37:11 -0500
Received: by mail-qt1-f193.google.com with SMTP id 30so26515057qtz.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 11:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=o0zrvyMBRXYkoG1uZ9FuMgX8jM9nuRXtxw/a+cZ+hwQ=;
        b=Wf5h3r664CU1Lu3IcZIgTny0LBq5BgU54bDVwuXTpS6CtF6pRmgYKM1qnNOLXUFMQF
         PUtiDgN9cDJCE3oUHDQ3PGaWtynOJ3qMrzYUe5kBNWikeiA2bFzyigp7JIy0mdWUKjyG
         0lj7KO3Cq1+nbnzUv2MVJEziVx+NHYU6PUuDNezHJOrm/vd3H2o7yB4QGrmphxfqeAVf
         7Mzn3Hr6apHI/WFXcRgI5tuNPOa12080jjJpkV3Gyk+DkHHRZO2wsu+6gHBX4wqRVATk
         EDg7GhKoy6Sn1u1o83eaPzvM0X2O8ohJ93CEWJjw9t55DoVYUL4fFHHLdkRoAtC3De9Z
         Uayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=o0zrvyMBRXYkoG1uZ9FuMgX8jM9nuRXtxw/a+cZ+hwQ=;
        b=a7QMXJ+57ro1xyP4mSAEwdWzGFpPqhAMyfkNnoVz3KzKzPh+MqmIKzDMCzGBvK30Gx
         JdaGK9WvrxDTLqD4AyVAtWfnPrZAYOTN0ZLJ/d8SenlNyEi4lugrueLpLzU67MOQ4mOp
         /XY1c8DlcjfXJFX8b5yMbeh90FSQ/cbzcLqW2IpS4WB0RtyqFOiQFsinZQuk5pFRzeam
         z93zGX0049WAG0AswLijwvAtVCe2z64EVGo4h3A0I3HVYaILm7TVFrd9z+K08thvbGIN
         t1dOqtk9oR2mLpefJEt1q7YtX3E3F5kCEbPPS6mesJ2aaKLB/JtpLLyvsdpuD6Lo/WFc
         e0Tg==
X-Gm-Message-State: APjAAAWFYR8Uwh1Wvem6idcDPOB97DRodlf2Qo0PIwpUs1YcnlugJgJz
        wNxF4sacnwAB50d026e9XvP7kA==
X-Google-Smtp-Source: APXvYqxGlPV+4tr2yZvZ8TnVOLOXHwvOWaWGqj044iJNZi51DnFtdbCi51oPe/3NvHuinWxS/WbuXQ==
X-Received: by 2002:ac8:2a1d:: with SMTP id k29mr43170806qtk.336.1574883430580;
        Wed, 27 Nov 2019 11:37:10 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id g7sm7291726qkl.20.2019.11.27.11.37.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 11:37:09 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in find_(smallest|biggest)_section_pfn
Date:   Wed, 27 Nov 2019 14:37:09 -0500
Message-Id: <CE5C4BD6-FAA6-4439-B869-679D24C17298@lca.pw>
References: <1F8C5EE3-4F07-4B23-9612-25FA265557C5@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <1F8C5EE3-4F07-4B23-9612-25FA265557C5@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 27, 2019, at 2:06 PM, David Hildenbrand <david@redhat.com> wrote:
>=20
> The zone pointer is unique for every node. (in contrast to the zone index)=
.

I am not sure if it is worth optimizing there. The existing nid check looks q=
uite straight-forward and cheap.=
