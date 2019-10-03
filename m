Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1640FC10F14
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D913821A4C
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 11:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ApEpOv4I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbfJCLTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 07:19:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38999 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729241AbfJCLTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 07:19:17 -0400
Received: by mail-qk1-f194.google.com with SMTP id 4so1918792qki.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Oct 2019 04:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=j+LY7SBrpaPWN8ZunyPxCza+/gP8sBOqig05DwJQYFY=;
        b=ApEpOv4IeWriJlUn5gRN+xzsCLmXeQKY2qkAlssw/67TrWl8dFK4APF2cv08pUeA6K
         9CnxQldWMkRybFAcjZwqMtlRUh9GD3p4u3izVKX+2yIFQ0h84BvB5Pq2zRJzrjPgVOLs
         RO55OzYh2I+zLOKDt+z9zOtlbMgYzJeH38h6Yr0lm7R/ISMb8Y85zLXfYhWZKgfC0DMV
         uPQbfGX+yojWi9Dc0b6OzVUM+X5qDzxZcjnjzHO7c4D0RYpvVaDLn5HOJkpdGoJhVS51
         fXTj8enyEH1b6iZJL3lvF7+m7PGoqV5BYeVl9KA+Xbtt5mnI67+xaj12xy+rYbQJVZiO
         pUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=j+LY7SBrpaPWN8ZunyPxCza+/gP8sBOqig05DwJQYFY=;
        b=AByj/DJFiLkbLlUTLt0Razn7Y1DrIyJHywx6AwbYl8PeOYzmTCaNs4cDiOLcEeSQ3a
         ogNCtipWB5TIshHXz58TW8Yxnl/t7QCB1Yc/LwgFZ6JXqypmGkhXINB5I2FNritGzUXb
         86G4ew+o2h+KA3LsQZfcMZySlZmWiBDa3jkoCOzUeuj9C9MkhomBqd4GBI8tT7dswv5W
         7S80NFKKh0bI52IsrIgkZIIIdA+b3zrCfmjP0gjf+Ee3wkEUwQR93DRPeE6kZGSYI4Pe
         1B8UVOo9zRvnjW7WeCIILBx79/45Pn/0I2XXYPIyB+AoKnrmxqSZJUpMUbkgVDjQ0LzF
         Khag==
X-Gm-Message-State: APjAAAVPNtaTfd75HRi8endBNEf+tIPuQih71zyDo5+EWYCarzMjWKTp
        j1W4PwQXj6ZBnN7wCjdDibGL2w==
X-Google-Smtp-Source: APXvYqxW4gB/kYtHI5Of00L1W60hX0JJhtdRgri4WP/QFf4o/BePI+7/OvNdO3N3HdmZ3pS3PHx9BQ==
X-Received: by 2002:ae9:f215:: with SMTP id m21mr3781093qkg.47.1570101556499;
        Thu, 03 Oct 2019 04:19:16 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z38sm1355269qtj.83.2019.10.03.04.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Oct 2019 04:19:15 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page_alloc: Add a reason for reserved pages in has_unmovable_pages()
Date:   Thu, 3 Oct 2019 07:19:15 -0400
Message-Id: <285C0297-BF27-4095-87B6-AFC88C1F3C0F@lca.pw>
References: <37b43978-5652-576c-8990-451e751b7c67@arm.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <37b43978-5652-576c-8990-451e751b7c67@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
X-Mailer: iPhone Mail (17A844)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 3, 2019, at 5:32 AM, Anshuman Khandual <Anshuman.Khandual@arm.com> w=
rote:
>=20
> Even though page flags does contain reserved bit information, the problem
> is that we are explicitly printing the reason for this page dump. In this
> case it is caused by the fact that it is a reserved page.
>=20
> page dumped because: <reason>
>=20
> The proposed change makes it explicit that the dump is caused because a
> non movable page with reserved bit set. It also helps in differentiating=20=

> between reserved bit condition and the last one "if (found > count)".

Then, someone later would like to add a reason for every different page flag=
s just because they *think* they are special.=
