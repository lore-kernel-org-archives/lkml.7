Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A650FC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7687F206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731386AbfCaSOR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 14:14:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49914 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730662AbfCaSOQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 14:14:16 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CEADDC058CC0;
        Sun, 31 Mar 2019 18:14:15 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-76.rdu2.redhat.com [10.10.120.76])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3CDBB1001E91;
        Sun, 31 Mar 2019 18:14:14 +0000 (UTC)
Subject: Re: fs/coda oops bisected to (925b9cd1b8) "locking/rwsem: Make owner
 store task pointer of last owni
To:     Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Pedro Cuadra Chamorro <pcuadrac@cs.cmu.edu>,
        linux-kernel@vger.kernel.org
References: <20190331040023.qbx52lwzufkxg3kw@cs.cmu.edu>
From:   Waiman Long <longman@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=longman@redhat.com; prefer-encrypt=mutual; keydata=
 xsFNBFgsZGsBEAC3l/RVYISY3M0SznCZOv8aWc/bsAgif1H8h0WPDrHnwt1jfFTB26EzhRea
 XQKAJiZbjnTotxXq1JVaWxJcNJL7crruYeFdv7WUJqJzFgHnNM/upZuGsDIJHyqBHWK5X9ZO
 jRyfqV/i3Ll7VIZobcRLbTfEJgyLTAHn2Ipcpt8mRg2cck2sC9+RMi45Epweu7pKjfrF8JUY
 r71uif2ThpN8vGpn+FKbERFt4hW2dV/3awVckxxHXNrQYIB3I/G6mUdEZ9yrVrAfLw5M3fVU
 CRnC6fbroC6/ztD40lyTQWbCqGERVEwHFYYoxrcGa8AzMXN9CN7bleHmKZrGxDFWbg4877zX
 0YaLRypme4K0ULbnNVRQcSZ9UalTvAzjpyWnlnXCLnFjzhV7qsjozloLTkZjyHimSc3yllH7
 VvP/lGHnqUk7xDymgRHNNn0wWPuOpR97J/r7V1mSMZlni/FVTQTRu87aQRYu3nKhcNJ47TGY
 evz/U0ltaZEU41t7WGBnC7RlxYtdXziEn5fC8b1JfqiP0OJVQfdIMVIbEw1turVouTovUA39
 Qqa6Pd1oYTw+Bdm1tkx7di73qB3x4pJoC8ZRfEmPqSpmu42sijWSBUgYJwsziTW2SBi4hRjU
 h/Tm0NuU1/R1bgv/EzoXjgOM4ZlSu6Pv7ICpELdWSrvkXJIuIwARAQABzR9Mb25nbWFuIExv
 bmcgPGxsb25nQHJlZGhhdC5jb20+wsF/BBMBAgApBQJYLGRrAhsjBQkJZgGABwsJCAcDAgEG
 FQgCCQoLBBYCAwECHgECF4AACgkQbjBXZE7vHeYwBA//ZYxi4I/4KVrqc6oodVfwPnOVxvyY
 oKZGPXZXAa3swtPGmRFc8kGyIMZpVTqGJYGD9ZDezxpWIkVQDnKM9zw/qGarUVKzElGHcuFN
 ddtwX64yxDhA+3Og8MTy8+8ZucM4oNsbM9Dx171bFnHjWSka8o6qhK5siBAf9WXcPNogUk4S
 fMNYKxexcUayv750GK5E8RouG0DrjtIMYVJwu+p3X1bRHHDoieVfE1i380YydPd7mXa7FrRl
 7unTlrxUyJSiBc83HgKCdFC8+ggmRVisbs+1clMsK++ehz08dmGlbQD8Fv2VK5KR2+QXYLU0
 rRQjXk/gJ8wcMasuUcywnj8dqqO3kIS1EfshrfR/xCNSREcv2fwHvfJjprpoE9tiL1qP7Jrq
 4tUYazErOEQJcE8Qm3fioh40w8YrGGYEGNA4do/jaHXm1iB9rShXE2jnmy3ttdAh3M8W2OMK
 4B/Rlr+Awr2NlVdvEF7iL70kO+aZeOu20Lq6mx4Kvq/WyjZg8g+vYGCExZ7sd8xpncBSl7b3
 99AIyT55HaJjrs5F3Rl8dAklaDyzXviwcxs+gSYvRCr6AMzevmfWbAILN9i1ZkfbnqVdpaag
 QmWlmPuKzqKhJP+OMYSgYnpd/vu5FBbc+eXpuhydKqtUVOWjtp5hAERNnSpD87i1TilshFQm
 TFxHDzbOwU0EWCxkawEQALAcdzzKsZbcdSi1kgjfce9AMjyxkkZxcGc6Rhwvt78d66qIFK9D
 Y9wfcZBpuFY/AcKEqjTo4FZ5LCa7/dXNwOXOdB1Jfp54OFUqiYUJFymFKInHQYlmoES9EJEU
 yy+2ipzy5yGbLh3ZqAXyZCTmUKBU7oz/waN7ynEP0S0DqdWgJnpEiFjFN4/ovf9uveUnjzB6
 lzd0BDckLU4dL7aqe2ROIHyG3zaBMuPo66pN3njEr7IcyAL6aK/IyRrwLXoxLMQW7YQmFPSw
 drATP3WO0x8UGaXlGMVcaeUBMJlqTyN4Swr2BbqBcEGAMPjFCm6MjAPv68h5hEoB9zvIg+fq
 M1/Gs4D8H8kUjOEOYtmVQ5RZQschPJle95BzNwE3Y48ZH5zewgU7ByVJKSgJ9HDhwX8Ryuia
 79r86qZeFjXOUXZjjWdFDKl5vaiRbNWCpuSG1R1Tm8o/rd2NZ6l8LgcK9UcpWorrPknbE/pm
 MUeZ2d3ss5G5Vbb0bYVFRtYQiCCfHAQHO6uNtA9IztkuMpMRQDUiDoApHwYUY5Dqasu4ZDJk
 bZ8lC6qc2NXauOWMDw43z9He7k6LnYm/evcD+0+YebxNsorEiWDgIW8Q/E+h6RMS9kW3Rv1N
 qd2nFfiC8+p9I/KLcbV33tMhF1+dOgyiL4bcYeR351pnyXBPA66ldNWvABEBAAHCwWUEGAEC
 AA8FAlgsZGsCGwwFCQlmAYAACgkQbjBXZE7vHeYxSQ/+PnnPrOkKHDHQew8Pq9w2RAOO8gMg
 9Ty4L54CsTf21Mqc6GXj6LN3WbQta7CVA0bKeq0+WnmsZ9jkTNh8lJp0/RnZkSUsDT9Tza9r
 GB0svZnBJMFJgSMfmwa3cBttCh+vqDV3ZIVSG54nPmGfUQMFPlDHccjWIvTvyY3a9SLeamaR
 jOGye8MQAlAD40fTWK2no6L1b8abGtziTkNh68zfu3wjQkXk4kA4zHroE61PpS3oMD4AyI9L
 7A4Zv0Cvs2MhYQ4Qbbmafr+NOhzuunm5CoaRi+762+c508TqgRqH8W1htZCzab0pXHRfywtv
 0P+BMT7vN2uMBdhr8c0b/hoGqBTenOmFt71tAyyGcPgI3f7DUxy+cv3GzenWjrvf3uFpxYx4
 yFQkUcu06wa61nCdxXU/BWFItryAGGdh2fFXnIYP8NZfdA+zmpymJXDQeMsAEHS0BLTVQ3+M
 7W5Ak8p9V+bFMtteBgoM23bskH6mgOAw6Cj/USW4cAJ8b++9zE0/4Bv4iaY5bcsL+h7TqQBH
 Lk1eByJeVooUa/mqa2UdVJalc8B9NrAnLiyRsg72Nurwzvknv7anSgIkL+doXDaG21DgCYTD
 wGA5uquIgb8p3/ENgYpDPrsZ72CxVC2NEJjJwwnRBStjJOGQX4lV1uhN1XsZjBbRHdKF2W9g
 weim8xU=
Organization: Red Hat
Message-ID: <497db260-fb1e-4b37-319f-6806df87f270@redhat.com>
Date:   Sun, 31 Mar 2019 14:14:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190331040023.qbx52lwzufkxg3kw@cs.cmu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Sun, 31 Mar 2019 18:14:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/31/2019 12:00 AM, Jan Harkes wrote:
> On Fri, Mar 29, 2019 at 05:53:22PM +0000, Waiman Long wrote:
>> On 03/29/2019 12:10 PM, Jan Harkes wrote:
>>> I knew I definitely had never seen this problem with the stable kernel
>>> on Ubuntu xenial (4.4) so I bisected between v4.4 and v5.1-rc2 and ended
>>> up at
>>>
>>>     # first bad commit: [925b9cd1b89a94b7124d128c80dfc48f78a63098]
>>>     # locking/rwsem: Make owner store task pointer of last owning reader
>>>
>>> When I revert this particular commit on 5.1-rc2, I am not able to
>>> reproduce the problem anymore.
>> Without CONFIG_DEBUG_RWSEMS, the only behavioral change of this patch is
>> to do an unconditional write of task_structure pointer into sem->owner
>> after acquiring the read lock in down_read(). Before this patch, it does
> I tried with just that change, but that is not at fault. It is also hard
> to believe we have a use-after-free issue, because we are using a
> spinlock on the inode that is held in place by the file we are releasing.

One possibility is that there is a previous reference to the memory
currently occupied by the spinlock. If the memory location is previously
part of a rwsem structure and someone is still using it, you may get
memory corruption.

> After trying various variations the minimal change that fixes the soft
> lockup is as follows. Without this patch I get a reliable lockup, with
> the patch everything works as expected.
>
>
>     diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
>     index bad2bca..0cc437d 100644
>     --- a/kernel/locking/rwsem.h
>     +++ b/kernel/locking/rwsem.h
>     @@ -61,8 +61,7 @@ static inline void rwsem_clear_owner(struct rw_semaphore *sem)
>      static inline void __rwsem_set_reader_owned(struct rw_semaphore *sem,
>                                                 struct task_struct *owner)
>      {
>     -	unsigned long val = (unsigned long)owner | RWSEM_READER_OWNED
>     -						 | RWSEM_ANONYMOUSLY_OWNED;
>     +	unsigned long val = RWSEM_READER_OWNED | RWSEM_ANONYMOUSLY_OWNED;
>      
>             WRITE_ONCE(sem->owner, (struct task_struct *)val);
>      }

The change above clears all the upper bytes of owner to 0, while the
original code will write some non-zero values to the upper bytes.

>
> I'll continue digging if I can find a reason why. So far I've only found
> one place where rwsem->owner is modified while not holding a lock, but
> changing that doesn't make a difference for my particular case.
>
>
>     diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
>     index 03cb4b6f842e..fe696a8b57f3 100644
>     --- a/include/linux/percpu-rwsem.h
>     +++ b/include/linux/percpu-rwsem.h
>     @@ -114,11 +114,11 @@ extern void percpu_free_rwsem(struct percpu_rw_semaphore *);
>      static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
>                                             bool read, unsigned long ip)
>      {
>     -	lock_release(&sem->rw_sem.dep_map, 1, ip);
>      #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
>             if (!read)
>                     sem->rw_sem.owner = RWSEM_OWNER_UNKNOWN;
>      #endif
>     +	lock_release(&sem->rw_sem.dep_map, 1, ip);
>      }
>      
>      static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
>
>
> Jan

The rwsem is still locked. The above code releases the current task from
being the lock holder of the rwsem from lockdep's perspective. Later on
some other task will take over the ownership of the rwsem without
actually releasing the lock in the interim. So I don't think this code
is part of the problem.

Cheers,
Longman


