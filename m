Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C04DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B74F2184C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 03:32:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sUb2N84b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfCNDc4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 23:32:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:52088 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfCNDcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 23:32:55 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2E3OdhB036181;
        Thu, 14 Mar 2019 03:32:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=WRqcqZ4kXuW7vZKjH17CWYvJASQzuIBvHvESiGMAEbM=;
 b=sUb2N84bVA5hJ3wbQbPsi5vAHcKtQgaPRq2fIK7XJHqKOkmHCNxwMtxlINQilhROO498
 kOBYs5wQSlxg9nBmtLcFVgWY8OlAmrBh/FRjhB6nNlU69ko5hYKBW7DmVLOBhgL8HMzw
 1b6DBu/IjlJ1u82gb7hj98hFBoU7uNCpNXpQ/pHgwmXGGnR934QwV2HfrSn41JxOcUTS
 sAMTx24d6M0Q+5FEhHlD4kbLE3HGc2sAYABmQ4oVPtC0WR0Cz25IQTurzwwtD3IRnKOm
 NpVKHF9ro4vPfoGJxZ7zPBw5RKRbm9RovUk/PY09YBK5CiRO1Zkw02+M0JjrA7ViZFDk gA== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp2130.oracle.com with ESMTP id 2r430ey0jm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 03:32:34 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x2E3WXbV019520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Mar 2019 03:32:33 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2E3WPAU002926;
        Thu, 14 Mar 2019 03:32:25 GMT
Received: from [192.168.1.222] (/50.38.38.67)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Mar 2019 20:32:25 -0700
Subject: Re: [PATCH 0/3] userfaultfd: allow to forbid unprivileged users
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        linux-kernel@vger.kernel.org, Hugh Dickins <hughd@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Maxime Coquelin <maxime.coquelin@redhat.com>,
        kvm@vger.kernel.org, Jerome Glisse <jglisse@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Martin Cracauer <cracauer@cons.org>,
        Denis Plotnikov <dplotnikov@virtuozzo.com>, linux-mm@kvack.org,
        Marty McFadden <mcfadden8@llnl.gov>,
        Maya Gokhale <gokhale2@llnl.gov>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-fsdevel@vger.kernel.org,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20190311093701.15734-1-peterx@redhat.com>
 <58e63635-fc1b-cb53-a4d1-237e6b8b7236@oracle.com>
 <20190313060023.GD2433@xz-x1>
 <3714d120-64e3-702e-6eef-4ef253bdb66d@redhat.com>
 <20190313185230.GH25147@redhat.com>
 <e1fcdd99-20d3-c161-8a05-b98b8036137c@oracle.com>
 <20190313235534.GK25147@redhat.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <a112a896-0629-d967-ab08-8d25970f9a9f@oracle.com>
Date:   Wed, 13 Mar 2019 20:32:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313235534.GK25147@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9194 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903140021
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/13/19 4:55 PM, Andrea Arcangeli wrote:
> On Wed, Mar 13, 2019 at 01:01:40PM -0700, Mike Kravetz wrote:
>> On 3/13/19 11:52 AM, Andrea Arcangeli wrote:
>>> Unless somebody suggests a consistent way to make hugetlbfs "just
>>> work" (like we could achieve clean with CRIU and KVM), I think Oracle
>>> will need a one liner change in the Oracle setup to echo into that
>>> file in addition of running the hugetlbfs mount.
>>
>> I think you are suggesting the DB setup process enable uffd for all users.
>> Correct?
> 
> Yes. In addition of the hugetlbfs setup, various apps requires to also
> increase fs.inotify.max_user_watches or file-max and other tweaks,
> this would be one of those tweaks.

Yes, I agree.
It is just that unprivileged_userfaultfd disabled would likely to be the
default set by distros.  Or, perhaps 'kvm'?  Then, if you want to run the
DB, the admin (or the DB) will need to set it to enabled.  And, this results
in it being enabled for everyone.  I think I understand the scope of any
security exposure this would cause from a technical perspective.  However,
I can imagine people being concerned about enabling everywhere if this is
not the default setting.

If it is OK to disable everywhere, why not just use disable for the kvm
use case as well? :)

>> This may be too simple, and I don't really like group access, but how about
>> just defining a uffd group?  If you are in the group you can make uffd
>> system calls.
> 
> Everything is possible, I'm just afraid it gets too complex.
> 
> So you suggest to echo a gid into the file?

That is what I was thinking.  But, I was mostly thinking of that because
Peter's earlier comment made me go and check hugetlbfs code.  There is a
sysctl_hugetlb_shm_group variable that does this, even though it is mostly
unused in the hugetlbfs code.

I know the kvm dev open scheme works for kvm.  Was just trying to think
of something more general that would work for hugetlbfs/DB or other use
cases.
-- 
Mike Kravetz
