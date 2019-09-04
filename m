Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED72C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F271622CF7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:14:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="GobjYdq+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbfIDIOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:14:49 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:13322 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725267AbfIDIOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:14:48 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx08-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x848D0Cm025011;
        Wed, 4 Sep 2019 10:14:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=qHDlQXISSQQ5My5NGD9l2kv4AXQH0OENOlb9eePRyqw=;
 b=GobjYdq+I54X92tVPCAFnM+rkF8uXf4qMyTs6Jp5NdLk26/j7KjAmfwIm21SXP96SL3z
 VG5Rnzpk/NQVlQo/GOvbF26ZUm9i5TuaRv1ymjK8PtLkFPGDO/wmw0CQPRQEWdGWjOd6
 jq1mKC341plqfU1hQX1XPtjk3VpsbIeS91flEAbG15HrXOvHq92yGA5xd4iE2HlLv95p
 vRuI9AzhPWzh1VEZMajw/iiU8mUJGcZDrmriEanegbYGCmDxmW07B9/DB+aUFbQo6qsN
 X5QmEgh+K6rf/h6at8H671FKV7DQkNGs1eTQxhOyG4JR/5vZ6YWVfggdCALvqcUM9ERh Iw== 
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
        by mx08-00178001.pphosted.com with ESMTP id 2uqe19r5hn-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 04 Sep 2019 10:14:30 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 3893A24;
        Wed,  4 Sep 2019 08:14:18 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 895022BC203;
        Wed,  4 Sep 2019 10:14:17 +0200 (CEST)
Received: from [10.48.0.131] (10.75.127.47) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 10:14:16 +0200
Subject: Re: [PATCH v5 1/2] rpmsg: core: add API to get message length
To:     Suman Anna <s-anna@ti.com>, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>
CC:     Fabien DESSENNE <fabien.dessenne@st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>
References: <1567005566-10986-1-git-send-email-arnaud.pouliquen@st.com>
 <1567005566-10986-2-git-send-email-arnaud.pouliquen@st.com>
 <7dc4d1cf-4f15-19ab-b8dd-424175f2a11a@ti.com>
 <f6f2ad3e-123a-268b-2586-544752c54db7@st.com>
 <2a81a04d-e4f9-b9c8-57ec-47f8e140235a@ti.com>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Message-ID: <d38057ed-d6f6-6b21-263a-6b83d1380ec5@st.com>
Date:   Wed, 4 Sep 2019 10:14:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2a81a04d-e4f9-b9c8-57ec-47f8e140235a@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.70,1.0.8
 definitions=2019-09-04_01:2019-09-03,2019-09-04 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suman

On 9/3/19 6:06 PM, Suman Anna wrote:
> Hi Arnaud,
> 
> On 9/3/19 4:49 AM, Arnaud Pouliquen wrote:
>> hi Suman
>>
>> On 8/29/19 12:34 AM, Suman Anna wrote:
>>> Hi Arnaud,
>>>
>>> On 8/28/19 10:19 AM, Arnaud Pouliquen wrote:
>>>> Return the rpmsg buffer size for sending message, so rpmsg users
>>>> can split a long message in several sub rpmsg buffers.
>>>
>>> Thanks for the patch, I also have a need for the same to be able to
>>> compute permissible payload size. Minor comments below.
>>
>> Thanks for your review. i will update it ASAP. Then if you need it and
>> ack it, i suppose that we could request Bjorn to integrate it in a first
>> step, if the rpmsg tty driver has not a level of quality sufficient to
>> be accepted...
> 
> Yeah, this patch can always be merged independently ahead of the rpmsg
> tty driver. Anyways, the tty patch will have to be picked up by a
> separate maintainer right. So, it would be nice to get the revised
> version get into 5.4

Sure, I plan to send a new version of the series today.
I would prefer not to split the series, just to simplify the review and 
the tests. if this patch is cherry-picked and integrated independently 
by Bjorn, I will simply sent a new version of the rpmsg tty driver 
without it.

Regards
Arnaud

> 
> regards
> Suman
> 
>>
>> Regards
>> Arnaud
>>>
>>>>
>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>>> ---
>>>> V4 to V5 :
>>>>     - rename rpmsg_get_buf_payload_size to rpmsg_get_mtu
>>>>
>>>>    drivers/rpmsg/rpmsg_core.c       | 21 +++++++++++++++++++++
>>>>    drivers/rpmsg/rpmsg_internal.h   |  2 ++
>>>>    drivers/rpmsg/virtio_rpmsg_bus.c | 10 ++++++++++
>>>>    include/linux/rpmsg.h            | 10 ++++++++++
>>>>    4 files changed, 43 insertions(+)
>>>>
>>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>>> index 8122807db380..daca2e24fc71 100644
>>>> --- a/drivers/rpmsg/rpmsg_core.c
>>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>>> @@ -283,6 +283,27 @@ int rpmsg_trysend_offchannel(struct
>>>> rpmsg_endpoint *ept, u32 src, u32 dst,
>>>>    }
>>>>    EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>>>>    +/**
>>>> + * rpmsg_get_mtu() - get maximum transmission buffer size for
>>>> sending message.
>>>> + * @ept: the rpmsg endpoint
>>>> + *
>>>> + * This function returns maximum buffer size available for a single
>>>> message.
>>>> + *
>>>> + * Return: the maximum transmission size on success and an
>>>> appropriate error
>>>> + * value on failure.
>>>> + */
>>>> +
>>>> +ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>>>> +{
>>>> +    if (WARN_ON(!ept))
>>>> +        return -EINVAL;
>>>> +    if (!ept->ops->get_buf_mtu)
>>>
>>> How about calling the ops just get_mtu or rename the function to follow
>>> the ops name, like all the others.
>>>
>>>> +        return -ENXIO;
>>>
>>> Perhaps ENOTSUPP or EOPNOTSUPP.
>>>
>>>> +
>>>> +    return ept->ops->get_buf_mtu(ept);
>>>> +}
>>>> +EXPORT_SYMBOL(rpmsg_get_mtu);
>>>> +
>>>>    /*
>>>>     * match an rpmsg channel with a channel info struct.
>>>>     * this is used to make sure we're not creating rpmsg devices for
>>>> channels
>>>> diff --git a/drivers/rpmsg/rpmsg_internal.h
>>>> b/drivers/rpmsg/rpmsg_internal.h
>>>> index 0d791c30b7ea..645c402569ac 100644
>>>> --- a/drivers/rpmsg/rpmsg_internal.h
>>>> +++ b/drivers/rpmsg/rpmsg_internal.h
>>>> @@ -46,6 +46,7 @@ struct rpmsg_device_ops {
>>>>     * @trysend:        see @rpmsg_trysend(), required
>>>>     * @trysendto:        see @rpmsg_trysendto(), optional
>>>>     * @trysend_offchannel:    see @rpmsg_trysend_offchannel(), optional
>>>> + * @get_buf_payload_size: see @rpmsg_get_buf_payload_size(), optional
>>>
>>> Missed updating the kerneldoc to the new name.
>>>
>>>>     *
>>>>     * Indirection table for the operations that a rpmsg backend should
>>>> implement.
>>>>     * In addition to @destroy_ept, the backend must at least implement
>>>> @send and
>>>> @@ -65,6 +66,7 @@ struct rpmsg_endpoint_ops {
>>>>                     void *data, int len);
>>>>        __poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>>>>                     poll_table *wait);
>>>> +    ssize_t (*get_buf_mtu)(struct rpmsg_endpoint *ept);
>>>>    };
>>>>      int rpmsg_register_device(struct rpmsg_device *rpdev);
>>>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c
>>>> b/drivers/rpmsg/virtio_rpmsg_bus.c
>>>> index e757f0038a1c..f80b1ad23e7e 100644
>>>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>>>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>>>> @@ -178,6 +178,7 @@ static int virtio_rpmsg_trysendto(struct
>>>> rpmsg_endpoint *ept, void *data,
>>>>                      int len, u32 dst);
>>>>    static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint
>>>> *ept, u32 src,
>>>>                           u32 dst, void *data, int len);
>>>> +static ssize_t virtio_get_buf_mtu(struct rpmsg_endpoint *ept);
>>>
>>> Minor nit, virtio_rpmsg_ prefix similar to all the other ops.
>>>
>>> regards
>>> Suman
>>>
>>>>      static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
>>>>        .destroy_ept = virtio_rpmsg_destroy_ept,
>>>> @@ -187,6 +188,7 @@ static const struct rpmsg_endpoint_ops
>>>> virtio_endpoint_ops = {
>>>>        .trysend = virtio_rpmsg_trysend,
>>>>        .trysendto = virtio_rpmsg_trysendto,
>>>>        .trysend_offchannel = virtio_rpmsg_trysend_offchannel,
>>>> +    .get_buf_mtu = virtio_get_buf_mtu,
>>>>    };
>>>>      /**
>>>> @@ -702,6 +704,14 @@ static int
>>>> virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
>>>>        return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len,
>>>> false);
>>>>    }
>>>>    +static ssize_t virtio_get_buf_mtu(struct rpmsg_endpoint *ept)
>>>> +{
>>>> +    struct rpmsg_device *rpdev = ept->rpdev;
>>>> +    struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
>>>> +
>>>> +    return vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
>>>> +}
>>>> +
>>>>    static int rpmsg_recv_single(struct virtproc_info *vrp, struct
>>>> device *dev,
>>>>                     struct rpmsg_hdr *msg, unsigned int len)
>>>>    {
>>>> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
>>>> index 9fe156d1c018..9d638bf2bdce 100644
>>>> --- a/include/linux/rpmsg.h
>>>> +++ b/include/linux/rpmsg.h
>>>> @@ -135,6 +135,8 @@ int rpmsg_trysend_offchannel(struct
>>>> rpmsg_endpoint *ept, u32 src, u32 dst,
>>>>    __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>>>>                poll_table *wait);
>>>>    +ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept);
>>>> +
>>>>    #else
>>>>      static inline int register_rpmsg_device(struct rpmsg_device *dev)
>>>> @@ -242,6 +244,14 @@ static inline __poll_t rpmsg_poll(struct
>>>> rpmsg_endpoint *ept,
>>>>        return 0;
>>>>    }
>>>>    +static ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept)
>>>> +{
>>>> +    /* This shouldn't be possible */
>>>> +    WARN_ON(1);
>>>> +
>>>> +    return -ENXIO;
>>>> +}
>>>> +
>>>>    #endif /* IS_ENABLED(CONFIG_RPMSG) */
>>>>      /* use a macro to avoid include chaining to get THIS_MODULE */
>>>>
>>>
> 
