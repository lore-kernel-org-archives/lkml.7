Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B67CEC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BE38206E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 22:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="PAARS5Pc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727503AbfK0W4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 17:56:44 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38269 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfK0W4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 17:56:44 -0500
Received: by mail-qk1-f193.google.com with SMTP id b8so6145995qkk.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2019 14:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=XYhfRwG5Ji2pvMuCuinGa1OmrcViu32wplTTKEJhTfk=;
        b=PAARS5PcPoQL3XS9GQzyp2fDTPw3+pUXtyo52tuExZFSfaIimO5e4M+TgBervYDP7U
         yhUVGPxTjccP9BCtGXAcM0XetuU1oUTzPeqhPmHoE1dMxcvPoLDnJX90nNtLptJD/uP1
         ju63egzcZc+qyp0v9JxEe0A4YxDXiDmyrT1WrJ7y9wECAYYxYgEATqabazbToNKHAofz
         hG4stzgnWmZYPw1NxrIoYc6eMbWT0WlB7un2ZhhwIi01p8TNCRLc82GUpEhYT1DNLY2D
         yeineiUFS+oLwXUsNXWGlIGyeTpyeIaE4Fct4BynsdREr5QLuW9ucMeYwnIPPYGUydxl
         zBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=XYhfRwG5Ji2pvMuCuinGa1OmrcViu32wplTTKEJhTfk=;
        b=I9PvdTXfP5aV1NZ+DVgj4jnBWToEAc2QKn0MeZncQqlUYi+WBdVqIHEOD9SeYjqzfP
         2GjbxUrIhjyGdUDrVn9+gUOdCvS1nzxbZL07z7upPCNjtTObFENJwJUb9kV2LotuXCfg
         gQKrTBMRxbMXgN2i0PUuX5sF8Zn8NJG3006UDWdX0Wtc8W865wWPe0KusbN8+FkTIShP
         RS19ZuMvq5Js6byisQvINgYUCsoWLx4LBCy+gninDwZDSK4X7BElWQuMOZwocCc46Khn
         6lD/w2cjZVlC/CwQdqOurLEDmDK6OHEsWjIsJA/OZMk/sCddl5kCUYeS4JMEoPh43qAB
         VGvw==
X-Gm-Message-State: APjAAAXq/m9RG62opQIUp/TOvNaC74PuWkjF41Hp/yIlowIEP0RRNC9D
        OELdRjJ7dQJ41tgtbxWAVco+bA==
X-Google-Smtp-Source: APXvYqzmKp4CtfXv6/HagS2sTgegvpTVS6zdaqSQywUUhkFMbj8c01JkSqjXG7xlf5mELrHR22q0Xg==
X-Received: by 2002:a37:b183:: with SMTP id a125mr6844021qkf.19.1574895401631;
        Wed, 27 Nov 2019 14:56:41 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id k26sm8134476qtm.10.2019.11.27.14.56.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 14:56:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v1] mm/memory_hotplug: don't check the nid in find_(smallest|biggest)_section_pfn
Date:   Wed, 27 Nov 2019 17:56:40 -0500
Message-Id: <555512D0-986D-437D-AE01-2087CB668F68@lca.pw>
References: <f2d5c2ed-b315-ee70-7d1e-b91d6d72a076@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>
In-Reply-To: <f2d5c2ed-b315-ee70-7d1e-b91d6d72a076@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Mailer: iPhone Mail (17A878)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 27, 2019, at 3:49 PM, David Hildenbrand <david@redhat.com> wrote:
>=20
> (I am a friend of cleaning up and refactoring code to make it easier to
> understand, maintain and extend. I was assuming your mentality is to
> rather keeping code changes minimal if there is a chance to break things
> - I'm sorry if that assumption was wrong.)

Yes, I tested linux-next everyday and saw enough of those cleanup efforts en=
ds up introducing regressions. It is almost every day or two I had to invest=
igate at least one regression and pick the suckers out even though my testin=
g is only focus on MM and friends. However, I do agree if there are worthy c=
leanup and refactoring but those tiny ones make me uncomfortable. See, I am j=
ust trying to save a real vacation for a few weeks in the future, but given t=
he current situation, I=E2=80=99ll need to give up on this project [1] at al=
l because I just have no courage to debug all the regressions there once bac=
k.

[1] https://github.com/cailca/linux-mm=
