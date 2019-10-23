Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0328CA9EB9
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:58:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68EC620663
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 22:58:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k/4I8aqT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392719AbfJWW6V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 18:58:21 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:51522 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbfJWW6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 18:58:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9NMuW77060287;
        Wed, 23 Oct 2019 22:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2019-08-05;
 bh=mALkVjqe/dJFWOA+4tAmvsRvDbr3+wKdwJ8X0lzXfnw=;
 b=k/4I8aqTrCxR9mMmyKw2CRiQQEi2p2m58pecHDF91Klae7yp8ZSY0ZH99VJFDa5dM3Jm
 93gsaMTqwg4dCmkSNcCsARoQRgX0AQnleWcMmBJhNilyNKrQfNspvT5OzJUP/JtQ6931
 iUiHA+0gwgSOAVll9FfZPkathFqmMCg0IndF2rCG5uQGCROV1sacvffKaIFiS7BbQ2dy
 5uln7j/q39ofI5x2ZIK67M7qRndwe2+yQS/jktDfu0RRivDXxUtu8wsPix0GrfXngSkk
 tto07CmaPk77GhCDtGsbbjqCypjpZngCqpGhxHNeKTSPTT435J+eN4Zw/gyhId7wLwP1 5w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2vqteq0asr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 22:57:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9NMs1XO058353;
        Wed, 23 Oct 2019 22:57:52 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2vtsk30uyg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Oct 2019 22:57:51 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9NMvpWl028525;
        Wed, 23 Oct 2019 22:57:51 GMT
Received: from dhcp-10-159-238-126.vpn.oracle.com (/10.159.238.126)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Oct 2019 15:57:50 -0700
Subject: Re: [PATCH 4/5] tracing: Handle the trace array ref counter in new
 functions
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Joe Jin <joe.jin@oracle.com>,
        Srinivas Eeda <srinivas.eeda@oracle.com>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
References: <1565805327-579-1-git-send-email-divya.indi@oracle.com>
 <1565805327-579-5-git-send-email-divya.indi@oracle.com>
 <20191015190436.65c8c7a3@gandalf.local.home>
 <4cad186e-ba8b-8e1a-731b-4350a095ba5a@oracle.com>
 <20191022225253.4086195c@oasis.local.home>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <2b08751a-4028-2130-9a70-c2aa2d76a31c@oracle.com>
Date:   Wed, 23 Oct 2019 15:57:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191022225253.4086195c@oasis.local.home>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910230205
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910230205
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,                                                                         
                                                                                 
A few clarifications on this discussion on reference counter -                   
                                                                                 
1) We will still need to export trace_array_put() to be used for every           
trace_array_get_by_name() OR trace_array_create() + trace_array_get().              
                                                                                 
How else will we reduce the reference counter [For eg: When multiple modules     
lookup the same trace array (say, reference counter = 4)]?                       
                                                                                 
2) tr = trace_array_create("my_tr");                                             
   trace_array_get(tr);                                                          
                                                                                 
Both of these functions will iterate through the list of trace arrays to verify  
whether the trace array exists (redundant, but more intuitive? Does this seem    
acceptable?)                                                                     
                                                                                 
To avoid iterating twice, we went with increasing ref_ctr in trace_array_create. 
This necessitated a trace_array_put() in instance_mkdir (Or as suggested below,
we can do this trace_array_put() in instance_rmdir().)                        
                                                                                                               
                                                                                 
3) A summary of suggested changes (Let me know if this looks good) -                                              
                                                                                 
tr = trace_array_get_by_name("foo-bar"); // ref_ctr++.                           
                                                                                 
if (!tr)                                                                         
{                                                                                
        // instance_mkdir also causes ref_ctr = 1                                
        tr = trace_array_create("foo-bar"); // ref_ctr = 1                       
        trace_array_get(tr); // ref_ctr++                                        
}                                                                                
                                                                                 
trace_array_printk(.....);                                                       
trace_array_set_clr_event(......);                                               
...                                                                              
...                                                                              
...                                                                              
// Done using the trace array.                                                   
trace_array_put(tr); // ref_ctr--                                                
...                                                                              
...                                                                              
...                                                                              
// We can now remove the trace array via trace_array_destroy or instance_rmdir()
trace_array_destroy(tr); // ref_ctr > 1 returns -EBUSY.
                                                       
                          
Thanks,                                                                          
Divya 

On 10/22/19 7:52 PM, Steven Rostedt wrote:
> On Wed, 16 Oct 2019 16:42:02 -0700
> Divya Indi <divya.indi@oracle.com> wrote:
>
>> Hi Steve,
>>
>> Thanks again for taking the time to review and providing feedback. Please find my comments inline.
>>
>> On 10/15/19 4:04 PM, Steven Rostedt wrote:
>>> Sorry for taking so long to getting to these patches.
>>>
>>> On Wed, 14 Aug 2019 10:55:26 -0700
>>> Divya Indi <divya.indi@oracle.com> wrote:
>>>  
>>>> For functions returning a trace array Eg: trace_array_create(), we need to
>>>> increment the reference counter associated with the trace array to ensure it
>>>> does not get freed when in use.
>>>>
>>>> Once we are done using the trace array, we need to call
>>>> trace_array_put() to make sure we are not holding a reference to it
>>>> anymore and the instance/trace array can be removed when required.  
>>> I think it would be more in line with other parts of the kernel if we
>>> don't need to do the trace_array_put() before calling
>>> trace_array_destroy().  
>> The reason we went with this approach is
>>
>> instance_mkdir -          ref_ctr = 0  // Does not return a trace array ptr.
>> trace_array_create -      ref_ctr = 1  // Since this returns a trace array ptr.
>> trace_array_lookup -      ref_ctr = 1  // Since this returns a trace array ptr.
>>
>> if we make trace_array_destroy to expect ref_ctr to be 1, we risk destroying the trace array while in use.
>>
>> We could make it -
>>
>> instance_mkdir - 	ref_ctr = 1
>> trace_array_create -    ref_ctr = 2
>> trace_array_lookup -    ref_ctr = 2+  // depending on no of lookups
>>
>> but, we'd still need the trace_array_put() (?)
>>
>> We can also have one function doing create (if does not exist) or lookup (if exists), but that would require
>> some redundant code since instance_mkdir needs to return -EXIST when a trace array already exists.
>>
>> Let me know your thoughts on this.
>>
> Can't we just move the trace_array_put() in the instance_rmdir()?
>
> static int instance_rmdir(const char *name)
> {
> 	struct trace_array *tr;
> 	int ret;
>
> 	mutex_lock(&event_mutex);
> 	mutex_lock(&trace_types_lock);
>
> 	ret = -ENODEV;
> 	list_for_each_entry(tr, &ftrace_trace_arrays, list) {
> 		if (tr->name && strcmp(tr->name, name) == 0) {
> 			__trace_array_put(tr);
> 			ret = __remove_instance(tr);
> 			if (ret)
> 				tr->ref++;
> 			break;
> 		}
> 	}
>
> 	mutex_unlock(&trace_types_lock);
> 	mutex_unlock(&event_mutex);
>
> 	return ret;
> }
>
> -- Steve
