Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D9F6C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DBBF207FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 09:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberfiber.eu header.i=@cyberfiber.eu header.b="ZB9nbOTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388318AbfJDJl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 05:41:29 -0400
Received: from filter01-out3.totaalholding.nl ([31.186.169.213]:49501 "EHLO
        filter01-out3.totaalholding.nl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388271AbfJDJl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 05:41:29 -0400
X-Greylist: delayed 1039 seconds by postgrey-1.27 at vger.kernel.org; Fri, 04 Oct 2019 05:41:28 EDT
Received: from www98.totaalholding.nl ([185.94.230.81])
        by filter01.totaalholding.nl with esmtps (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <mjbaars1977.linux-kernel@cyberfiber.eu>)
        id 1iGJol-0005lz-2x
        for linux-kernel@vger.kernel.org; Fri, 04 Oct 2019 11:24:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberfiber.eu; s=default; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=7fbCrmBoXH7A68+AJFpjQq9ukOe3qj5mwDOpBcXgXcg=; b=ZB9nbOTyUSvH59bqtyakZIw50V
        43DBF4n3H6jIHTy8qjk8QM7lJTV1uF4l1qrPixULXJ+ZviWTvY6W5UXt2mfyN+anyxi9QKuOO8pEg
        VNuHfZypmlwGaV+BUiWhoB5IwcxArkG5pB5QoKLGi+N4arphEJXzISWqyHqRcr8kzSAe/qbT31xT1
        5Be3/kKNjEeIJJ2KJ+S/9HkGoSE134dvMxuJfiUWx/PeGZIsqgJffM/AofrIzw785PIEEZNrEtJXv
        bhHqNd1IPHu5BqmsmaOdxb1v2bkfMlO7nlzuetZQ3olR9w9/yS/aw9/RDAJ3s2ZYQqh3u7yxPq+dX
        dANFGeng==;
Received: from [85.146.134.134] (port=60958 helo=DT0E.cyberfiber.eu)
        by www98.totaalholding.nl with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.92)
        (envelope-from <mjbaars1977.linux-kernel@cyberfiber.eu>)
        id 1iGJok-0000Dw-UX
        for linux-kernel@vger.kernel.org; Fri, 04 Oct 2019 11:24:06 +0200
Message-ID: <6dd0cf2a58a7f99da3d2fdfb9b1d1bf957409893.camel@cyberfiber.eu>
Subject: packet writing support
From:   Mischa Baars <mjbaars1977.linux-kernel@cyberfiber.eu>
To:     linux-kernel@vger.kernel.org
Date:   Fri, 04 Oct 2019 11:22:39 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - www98.totaalholding.nl
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cyberfiber.eu
X-Get-Message-Sender-Via: www98.totaalholding.nl: authenticated_id: mjbaars1977.linux-kernel@cyberfiber.eu
X-Authenticated-Sender: www98.totaalholding.nl: mjbaars1977.linux-kernel@cyberfiber.eu
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Originating-IP: 185.94.230.81
X-SpamExperts-Domain: out.totaalholding.nl
X-SpamExperts-Username: 185.94.230.81
Authentication-Results: totaalholding.nl; auth=pass smtp.auth=185.94.230.81@out.totaalholding.nl
X-SpamExperts-Outgoing-Class: unsure
X-SpamExperts-Outgoing-Evidence: Combined (0.37)
X-Recommended-Action: accept
X-Filter-ID: Mvzo4OR0dZXEDF/gcnlw0dWQ8c9lblW44odAlK6ziUapSDasLI4SayDByyq9LIhVP66eIxt/agQ7
 YJNlpgi5CETNWdUk1Ol2OGx3IfrIJKywOmJyM1qr8uRnWBrbSAGD2wvHbfwld3xCwVQvwEuT77Ld
 J48jzkmtY6e2hJZwYRTnx8yeplRO3sLIqUlSH7OGWh4Em/JI/vUjAvb24AuGwYMlhcTgOXSCz8qb
 ysTVYVkxZLzl78CRJp/CkBuSEXrbq0f8Oqhr0yw75RiyQ1Tv4oYfDsyVogV4aMr3Qc/zKVxPR9o0
 14ICOs9pIWX8OtLJj1pqXi8btQCfqom9tO+O5GjSUnK0zv6WWniSLupvi3/C3VvUdjSCswikK/li
 cfX+JDrjsxZHhy1AzMPULKZh4Agqdb/JjbdVZfbc9c+Jxpt+54iyUCc8aaknZho9naJYg0bolM7B
 /rBFul0ycjYHG0NfDxtcqznH5VBUud8O4LV0JmbqROuof5+bHLNCgb4217NirEYyqwqMBGrw8ELi
 qO86tByCP69i0Qh5ndH5heRCJ7rPXZbjpKeI7vxRvveCIK/1NH5THMtlYvyHAYGOGgjdb5hy4d8/
 k+RlvkD7ATmoZ2kfng5rdXwjvpU4S+XAhVR1id1GLKHJBvyjlI1w1E/J5phsv+xvB6Q7084Dep/E
 odhHmgT/Z/aIyKL3sc7t9dFZa5ukDvijt563XwguywX3MPaPCeumOhbpVZ03tIU95AZWtzQOODZY
 aBS/QaPai/btrmlhC85OkmJRZ+my2YLTiFllyX974CpAmwOWQt/Apnqpdot95Z1s2bBwfdm/8X6o
 RcYO63BwpS5C898CHX096OhfSRX9R5xa4rGFcC9OL4nawG8z87Sn7OLOV4LikazAQsNf7vua6ysA
 xFAilnb3SCYVYDSdH4IKBn5oTTl9HKvj+Li+B0slZd4aadi2b667E/1TXseb92FolcPTrPL5sKTz
 3tp9wpvGYs38JV+Sgf0DiLPRXTSWmFEPKyP0gxb6VQ9Dyf1mdym/fWDvnb+h1IgCQbaPY30Vfjqb
 xdTi1AYkryYheSAf/c7kR8HWm3EQIN2pUUDcOX/AZBHcfw==
X-Report-Abuse-To: spam@filter01.totaalholding.nl
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If I'm correct, packet writing support is going to be removed from the
Linux kernel. Is there any particular reason for
this, as far as you people know? Both DVD-writers and Blueray-writers are
still being sold to date.

I'm currently working on quite a large project. I would be dependent
solely on USB to store my backup files, when the packet writing support
is removed. Actually I'm quite uncomfortable with that idea, because
USB is rewritable. Any serious attempt to do damage to my project will
result a permanent loss of code. Personally I would do anything to keep
packet writing support in the kernel.

I'd hoped you could remove normal floppy disc support instead. That
seems the more logical course of action. Floppy disc drives aren't
being sold anymore for quite some years now.

Anybody there?

Have a pleasant day,
Mischa Baars.

