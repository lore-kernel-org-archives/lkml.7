Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0603BC06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:48:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7836F206A3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 14:48:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="a0RpyQJQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfGBOsf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 10:48:35 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:1949 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbfGBOse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 10:48:34 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62EhXlI005738;
        Tue, 2 Jul 2019 16:48:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=D7zgvjSLfqioMZan6qdNfokcmMkC9DF4WUgCZykLyz0=;
 b=a0RpyQJQ5gv/moPv1tZTyU7EnlOIDJoh+0uCM2M45OaDC042EU3GdKRHOdyI+Hke6Ti1
 qznbAY0X8lNomFhIXaeqvnNfndTsBeepMxoUJVL6cYU1zr726TZBN1XbfCnboDBhO3GU
 TBacoVzOiYSpzQMc9hRCMJIl40J6Gi8Ff8x9zukqqGMS87bfe0QSESxFoR68C/blGaH3
 z5VRBKBAK38pKaexMrtl04SF68ZnVyvQwAxK4GbJmrrYmJXrOn4BnC1c5HS6jFt+5Tb6
 v5asnWq05MJYbzSwKxNmI/LUiTrDHZgcZdqVGWRNsLpWWtkSePxOirXEbF22vVEI5Z1D RQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2tdwruvqb2-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 02 Jul 2019 16:48:20 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3351731;
        Tue,  2 Jul 2019 14:48:10 +0000 (GMT)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 05FB42C83;
        Tue,  2 Jul 2019 14:48:10 +0000 (GMT)
Received: from [10.48.0.131] (10.75.127.51) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Tue, 2 Jul
 2019 16:48:09 +0200
Subject: Re: [PATCH v2 1/2] rpmsg: core: add possibility to get message
 payload length
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        xiang xiao <xiaoxiang781216@gmail.com>,
        <linux-kernel@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        Fabien DESSENNE <fabien.dessenne@st.com>
References: <1557500577-22366-1-git-send-email-arnaud.pouliquen@st.com>
 <1557500577-22366-2-git-send-email-arnaud.pouliquen@st.com>
 <20190701053137.GC1263@builder>
From:   Arnaud Pouliquen <arnaud.pouliquen@st.com>
Openpgp: preference=signencrypt
Autocrypt: addr=arnaud.pouliquen@st.com; prefer-encrypt=mutual; keydata=
 xsFNBFZu+HIBEAC/bt4pnj18oKkUw40q1IXSPeDFOuuznWgFbjFS6Mrb8axwtnxeYicv0WAL
 rWhlhQ6W2TfKDJtkDygkfaZw7Nlsj57zXrzjVXuy4Vkezxtg7kvSLYItQAE8YFSOrBTL58Yd
 d5cAFz/9WbWGRf0o9MxFavvGQ9zkfHVd+Ytw6dJNP4DUys9260BoxKZZMaevxobh5Hnram6M
 gVBYGMuJf5tmkXD/FhxjWEZ5q8pCfqZTlN9IZn7S8d0tyFL7+nkeYldA2DdVplfXXieEEURQ
 aBjcZ7ZTrzu1X/1RrH1tIQE7dclxk5pr2xY8osNePmxSoi+4DJzpZeQ32U4wAyZ8Hs0i50rS
 VxZuT2xW7tlNcw147w+kR9+xugXrECo0v1uX7/ysgFnZ/YasN8E+osM2sfa7OYUloVX5KeUK
 yT58KAVkjUfo0OdtSmGkEkILWQLACFEFVJPz7/I8PisoqzLS4Jb8aXbrwgIg7d4NDgW2FddV
 X9jd1odJK5N68SZqRF+I8ndttRGK0o7NZHH4hxJg9jvyEELdgQAmjR9Vf0eZGNfowLCnVcLq
 s+8q3nQ1RrW5cRBgB8YT2kC8wwY5as8fhfp4846pe2b8Akh0+Vba5pXaTvtmdOMRrcS7CtF6
 Ogf9zKAxPZxTp0qGUOLE3PmSc3P3FQBLYa6Y+uS2v2iZTXljqQARAQABzSpBcm5hdWQgUG91
 bGlxdWVuIDxhcm5hdWQucG91bGlxdWVuQHN0LmNvbT7CwX4EEwECACgFAlZu+HICGyMFCQlm
 AYAGCwkIBwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEP0ZQ+DAfqbfdXgP/RN0bU0gq3Pm1uAO
 4LejmGbYeTi5OSKh7niuFthrlgUvzR4UxMbUBk30utQAd/FwYPHR81mE9N4PYEWKWMW0T3u0
 5ASOBLpQeWj+edSE50jLggclVa4qDMl0pTfyLKOodt8USNB8aF0aDg5ITkt0euaGFaPn2kOZ
 QWVN+9a5O2MzNR3Sm61ojM2WPuB1HobbrCFzCT+VQDy4FLU0rsTjTanf6zpZdOeabt0LfWxF
 M69io06vzNSHYH91RJVl9mkIz7bYEZTBQR23KjLCsRXWfZ+54x6d6ITYZ2hp965PWuAhwWQr
 DdTJ3gPxmXJ7xK9+O15+DdUAbxF9FJXvvt9U5pTk3taTM3FIp/qaw77uxI/wniYA0dnIJRX0
 o51sjR6cCO6hwLciO7+Q0OCDCbtStuKCCCTZY5bF6fuEqgybDwvLGAokYIdoMagJu1DLKu4p
 seKgPqGZ4vouTmEp6cWMzSyRz4pf3xIJc5McsdrUTN2LtcX63E45xKaj/n0Neft/Ce7OuyLB
 rr0ujOrVlWsLwyzpU5w5dX7bzkEW1Hp4mv44EDxH9zRiyI5dNPpLf57I83Vs/qP4bpy7/Hm1
 fqbuM0wMbOquPGFI8fcYTkghntAAXMqNE6IvETzYqsPZwT0URpOzM9mho8u5+daFWWAuUXGA
 qRbo7qRs8Ev5jDsKBvGhzsFNBFZu+HIBEACrw5wF7Uf1h71YD5Jk7BG+57rpvnrLGk2s+YVW
 zmKsZPHT68SlMOy8/3gptJWgddHaM5xRLFsERswASmnJjIdPTOkSkVizfAjrFekZUr+dDZi2
 3PrISz8AQBd+uJ29jRpeqViLiV+PrtCHnAKM0pxQ1BOv8TVlkfO7tZVduLJl5mVoz1sq3/C7
 hT5ZICc2REWrfS24/Gk8mmtvMybiTMyM0QLFZvWyvNCvcGUS8s2a8PIcr+Xb3R9H0hMnYc2E
 7bc5/e39f8oTbKI6xLLFLa5yJEVfTiVksyCkzpJSHo2eoVdW0lOtIlcUz1ICgZ7vVJg7chmQ
 nPmubeBMw73EyvagdzVeLm8Y/6Zux8SRab+ZcU/ZQWNPKoW5clUvagFBQYJ6I2qEoh2PqBI4
 Wx0g1ca7ZIwjsIfWS7L3e310GITBsDmIeUJqMkfIAregf8KADPs4+L71sLeOXvjmdgTsHA8P
 lK8kUxpbIaTrGgHoviJ1IYwOvJBWrZRhdjfXTPl+ZFrJiB2E55XXogAAF4w/XHpEQNGkAXdQ
 u0o6tFkJutsJoU75aHPA4q/OvRlEiU6/8LNJeqRAR7oAvTexpO70f0Jns9GHzoy8sWbnp/LD
 BSH5iRCwq6Q0hJiEzrVTnO3bBp0WXfgowjXqR+YR86JPrzw2zjgr1e2zCZ1gHBTOyJZiDwAR
 AQABwsFlBBgBAgAPBQJWbvhyAhsMBQkJZgGAAAoJEP0ZQ+DAfqbfs5AQAJKIr2+j+U3JaMs3
 px9bbxcuxRLtVP5gR3FiPR0onalO0QEOLKkXb1DeJaeHHxDdJnVV7rCJX/Fz5CzkymUJ7GIO
 gpUGstSpJETi2sxvYvxfmTvE78D76rM5duvnGy8lob6wR2W3IqIRwmd4X0Cy1Gtgo+i2plh2
 ttVOM3OoigkCPY3AGD0ts+FbTn1LBVeivaOorezSGpKXy3cTKrEY9H5PC+DRJ1j3nbodC3o6
 peWAlfCXVtErSQ17QzNydFDOysL1GIVn0+XY7X4Bq+KpVmhQOloEX5/At4FlhOpsv9AQ30rZ
 3F5lo6FG1EqLIvg4FnMJldDmszZRv0bR0RM9Ag71J9bgwHEn8uS2vafuL1hOazZ0eAo7Oyup
 2VNRC7Inbc+irY1qXSjmq3ZrD3SSZVa+LhYfijFYuEgKjs4s+Dvk/xVL0JYWbKkpGWRz5M82
 Pj7co6u8pTEReGBYSVUBHx7GF1e3L/IMZZMquggEsixD8CYMOzahCEZ7UUwD5LKxRfmBWBgK
 36tfTyducLyZtGB3mbJYfWeI7aiFgYsd5ehov6OIBlOz5iOshd97+wbbmziYEp6jWMIMX+Em
 zqSvS5ETZydayO5JBbw7fFBd1nGVYk1WL6Ll72g+iEnqgIckMtxey1TgfT7GhPkR7hl54ZAe
 8mOik8I/F6EW8XyQAA2P
Message-ID: <47f4ade7-1f9a-664e-1b6e-3c9f16df55d0@st.com>
Date:   Tue, 2 Jul 2019 16:48:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190701053137.GC1263@builder>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/1/19 7:31 AM, Bjorn Andersson wrote:
> On Fri 10 May 08:02 PDT 2019, Arnaud Pouliquen wrote:
> 
>> Return the rpmsg buffer payload size for sending message, so rpmsg users
>> can split a long message in several sub rpmsg buffers.
>>
>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>> Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
> 
> This should list each person who dealt with the patch. So the first
> would be the author and the last would be the one that posted it on the
> list.
> 
> If you both authored the patch then you should add Co-developed-by to
> denote this.
ok i will update it
> 
>> ---
>>  drivers/rpmsg/rpmsg_core.c       | 20 ++++++++++++++++++++
>>  drivers/rpmsg/rpmsg_internal.h   |  2 ++
>>  drivers/rpmsg/virtio_rpmsg_bus.c | 11 +++++++++++
>>  include/linux/rpmsg.h            | 10 ++++++++++
>>  4 files changed, 43 insertions(+)
>>
>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>> index 8122807db380..75c8c403ffe5 100644
>> --- a/drivers/rpmsg/rpmsg_core.c
>> +++ b/drivers/rpmsg/rpmsg_core.c
>> @@ -283,6 +283,26 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>>  }
>>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>>  
>> +/**
>> + * rpmsg_get_buf_payload_size()
>> + * This function returns buffer payload size available for sending messages.
>> + *
>> + * @ept: the rpmsg endpoint
>> + *
>> + * Returns buffer payload size on success and an appropriate error value on
>> + * failure.
>> + */
> 
> Please read
> https://www.kernel.org/doc/Documentation/kernel-doc-nano-HOWTO.txt
oops sorry for this dirty documentation.
> 
>> +int rpmsg_get_buf_payload_size(struct rpmsg_endpoint *ept)
> 
> payload size can have many meanings and hopefully we'll end up in a
> situation where its dynamic. But it could be considered useful to have a
> way to query the maximum transmission size in such a setup.
> 
> So please rename this rpmsg_get_mtu() or something similar.
> 
> And I would prefer ssize_t as return type.

ssize_t rpmsg_get_mtu(struct rpmsg_endpoint *ept) sounds good, ok for this
>> +{
>> +	if (WARN_ON(!ept))
>> +		return -EINVAL;
>> +	if (!ept->ops->get_buf_payload_size)
>> +		return -ENXIO;
>> +
>> +	return ept->ops->get_buf_payload_size(ept);
>> +}
>> +EXPORT_SYMBOL(rpmsg_get_buf_payload_size);
>> +
>>  /*
>>   * match an rpmsg channel with a channel info struct.
>>   * this is used to make sure we're not creating rpmsg devices for channels
>> diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
>> index 0d791c30b7ea..6f733a556139 100644
>> --- a/drivers/rpmsg/rpmsg_internal.h
>> +++ b/drivers/rpmsg/rpmsg_internal.h
>> @@ -46,6 +46,7 @@ struct rpmsg_device_ops {
>>   * @trysend:		see @rpmsg_trysend(), required
>>   * @trysendto:		see @rpmsg_trysendto(), optional
>>   * @trysend_offchannel:	see @rpmsg_trysend_offchannel(), optional
>> + * @get_buf_payload_size: see @rpmsg_get_buf_payload_size(), optional
>>   *
>>   * Indirection table for the operations that a rpmsg backend should implement.
>>   * In addition to @destroy_ept, the backend must at least implement @send and
>> @@ -65,6 +66,7 @@ struct rpmsg_endpoint_ops {
>>  			     void *data, int len);
>>  	__poll_t (*poll)(struct rpmsg_endpoint *ept, struct file *filp,
>>  			     poll_table *wait);
>> +	int (*get_buf_payload_size)(struct rpmsg_endpoint *ept);
>>  };
>>  
>>  int rpmsg_register_device(struct rpmsg_device *rpdev);
>> diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
>> index 5d3685bd76a2..82753e76e377 100644
>> --- a/drivers/rpmsg/virtio_rpmsg_bus.c
>> +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
>> @@ -175,6 +175,7 @@ static int virtio_rpmsg_trysendto(struct rpmsg_endpoint *ept, void *data,
>>  				  int len, u32 dst);
>>  static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
>>  					   u32 dst, void *data, int len);
>> +static int virtio_get_buf_payload_size(struct rpmsg_endpoint *ept);
>>  
>>  static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
>>  	.destroy_ept = virtio_rpmsg_destroy_ept,
>> @@ -184,6 +185,7 @@ static const struct rpmsg_endpoint_ops virtio_endpoint_ops = {
>>  	.trysend = virtio_rpmsg_trysend,
>>  	.trysendto = virtio_rpmsg_trysendto,
>>  	.trysend_offchannel = virtio_rpmsg_trysend_offchannel,
>> +	.get_buf_payload_size = virtio_get_buf_payload_size,
>>  };
>>  
>>  /**
>> @@ -699,6 +701,15 @@ static int virtio_rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src,
>>  	return rpmsg_send_offchannel_raw(rpdev, src, dst, data, len, false);
>>  }
>>  
>> +static int virtio_get_buf_payload_size(struct rpmsg_endpoint *ept)
>> +{
>> +	struct rpmsg_device *rpdev = ept->rpdev;
>> +	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
>> +	int size = vch->vrp->buf_size - sizeof(struct rpmsg_hdr);
>> +
>> +	return size < 0 ? -EMSGSIZE : size;
> 
> Seems that a rpmsg instance configured to not even have space for the
> rpmsg_hdr in each message is rather broken. Shouldn't this be prohibited
> elsewhere?
yes seems that the are some useless check in code on buf_size, i will
suppress the check here.
there are some other instances in code...For time being the size is
fixed, but good place seems to be in the rpmsg_probe probe function. i
will propose a patch to clean this.

Thanks,
Arnaud

> 
> Regards,
> Bjorn
> 
>> +}
>> +
>>  static int rpmsg_recv_single(struct virtproc_info *vrp, struct device *dev,
>>  			     struct rpmsg_hdr *msg, unsigned int len)
>>  {
>> diff --git a/include/linux/rpmsg.h b/include/linux/rpmsg.h
>> index 9fe156d1c018..250df2165086 100644
>> --- a/include/linux/rpmsg.h
>> +++ b/include/linux/rpmsg.h
>> @@ -135,6 +135,8 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>>  __poll_t rpmsg_poll(struct rpmsg_endpoint *ept, struct file *filp,
>>  			poll_table *wait);
>>  
>> +int rpmsg_get_buf_payload_size(struct rpmsg_endpoint *ept);
>> +
>>  #else
>>  
>>  static inline int register_rpmsg_device(struct rpmsg_device *dev)
>> @@ -242,6 +244,14 @@ static inline __poll_t rpmsg_poll(struct rpmsg_endpoint *ept,
>>  	return 0;
>>  }
>>  
>> +static int rpmsg_get_buf_payload_size(struct rpmsg_endpoint *ept)
>> +{
>> +	/* This shouldn't be possible */
>> +	WARN_ON(1);
>> +
>> +	return -ENXIO;
>> +}
>> +
>>  #endif /* IS_ENABLED(CONFIG_RPMSG) */
>>  
>>  /* use a macro to avoid include chaining to get THIS_MODULE */
>> -- 
>> 2.7.4
>>
